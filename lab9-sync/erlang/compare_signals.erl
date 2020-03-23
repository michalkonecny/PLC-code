-module(compare_signals).
-export([main/0, comparator/0, signalA/1, signalB/1]).

signalA(TargetPID) ->
    receive
        start -> 
            io:format("signalA starting~n",[]),
            random:seed(32,124,12)
    end,
    produceRandomSignal(TargetPID, signalA, 0),
    ok.
    
signalB(TargetPID) ->
    receive
        start -> 
            io:format("signalB starting~n",[]),
            random:seed(634,656,344674)
    end,
    produceRandomSignal(TargetPID, signalB, 0),
    ok.
    
produceRandomSignal(TargetPID, Id, Value) ->
    % check for termination
    receive
        stop ->
            exit("received stop message")
    after
        0 -> ok
    end,
    % signal change
    TargetPID ! {Id, Value},
    % wait for a random time between 0.1-2.0 sec
    timer:sleep(100 + random:uniform(1900)),
    % continue with the opposite value (0 -> 1, 1 -> 0)
    produceRandomSignal(TargetPID, Id, 1 - Value).

-record(signals_state, 
        {a_val, b_val, % 0 or 1
         last_change_time, % standard erlang time type
         agree_dur, total_dur}). % microseconds

initial_state() ->
    #signals_state
        { a_val = 0, b_val = 0, 
          last_change_time = erlang:now(), 
          agree_dur = 1, total_dur = 1 % avoid division by 0
        }.

update_timing(State) ->
    Now = erlang:now(),
    #signals_state
            {a_val = A, b_val = B,
             last_change_time = Old_last_c_t,
             total_dur = Old_total_dur,
             agree_dur = Old_agree_dur}
        = State,
    Last_Dur = timer:now_diff(Now, Old_last_c_t),
    New_total_dur = Old_total_dur + Last_Dur,
    if
        A == B ->
            New_agree_dur = Old_agree_dur + Last_Dur;
        true ->
            New_agree_dur = Old_agree_dur
    end,
    io:format("new agreement measure: ~6.2f%~n",
                [100 * New_agree_dur/New_total_dur]),
    State#signals_state
        {
            last_change_time = Now,
            total_dur = New_total_dur,
            agree_dur = New_agree_dur
        }.

comparator() ->
    receive
        start -> 
            io:format("comparator starting~n",[])
    end,
    compare_signals(initial_state()).
    
compare_signals(State) ->
    receive
        { signalA, Value } ->
            io:format("received from ~p value ~p~n", [signalA, Value]),
            compare_signals((update_timing(State))#signals_state{a_val = Value});
        { signalB, Value } ->
            io:format("received from ~p value ~p~n", [signalB, Value]),
            compare_signals((update_timing(State))#signals_state{b_val = Value});
        stop ->
            exit("received stop message")
    end.


main() ->
    CompPID = spawn(compare_signals, comparator, []),
    SigAPID = spawn(compare_signals, signalA, [CompPID]),
    SigBPID = spawn(compare_signals, signalB, [CompPID]),
    CompPID ! start,
    SigAPID ! start,
    SigBPID ! start,
    timer:sleep(10000),
    SigAPID ! stop,
    SigBPID ! stop,
    CompPID ! stop,
    ok.
    