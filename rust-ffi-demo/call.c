#include <stdio.h>

extern double rustfunc1(double);
extern double rustfunc2(char*);

int main() {
  printf("%f\n", rustfunc1(13.0));
  rustfunc2("aaaaa");
  return 0;
}
