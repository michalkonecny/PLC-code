-module(start_stop).
-export([main/0, print_numbers_wait/1, switch_on_off/1]).

main() ->
    io:format("start_stop starting~n"),
    PrintPID = spawn(start_stop, print_numbers_wait, [0]),
    SwitchPID = spawn(start_stop, switch_on_off, [PrintPID]),
    timer:sleep(10000),
    SwitchPID ! finish,
    PrintPID ! finish,
    io:format("start_stop finishing~n").

print_numbers_wait(N) ->
    receive
        start -> ok;
        finish -> exit("got finish signal")
    end,
    print_numbers_go(N).
    
print_numbers_go(N) ->
    io:format("~p~n", [N]),
    receive
        stop -> print_numbers_wait(N + 1);
        finish -> exit("got finish signal")
    after
        200 -> 
            print_numbers_go(N + 1)
    end.

switch_on_off(PrintPID) ->
    PrintPID ! start,
    receive
        finish -> exit("done")
    after
        1000 -> ok
    end,
    switch_off_on(PrintPID).

switch_off_on(PrintPID) ->
    PrintPID ! stop,
    receive
        finish -> exit("done")
    after
        1000 -> ok
    end,
    switch_on_off(PrintPID).
