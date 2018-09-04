class Circle {

  public static void main(String[] args) {
    int size = Integer.parseInt(args[0]);
    Circle c = new Circle(size);
    for (int i = 1; i <= size; i++ ) {
      System.out.println(c.circleLine(i));
    }
  }

  public Circle(int size) {
    this.size = size;
  }

  private int size;

  private String circleLine(int i){
    StringBuilder result = new StringBuilder(size);
    for (int jj = 1; jj <= 2*size; jj++) {
      if (shouldPaint(i,jj))
        { result.append('*'); }
      else
        { result.append(' '); }
    }
    return result.toString();
  }

  private Boolean shouldPaint(int i, int jj){
    int j = jj/2;
    return shouldPaintS(size,i,j);
  }

  private Boolean shouldPaintS(int s, int i, int j){
    return Math.abs (Math.pow(i,2) + Math.pow(j,2) - Math.pow(s,2)) <= s+1;
  }
}
