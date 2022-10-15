#include"stdio.h"
float a[5][5]={1.2,2.4,3.6,4.8,5.0};
float max;

//求二维数组元素之和
float sumfunc(float a[][5]){
    int i=0;
    int j;
    float sum=0;
    while(i<5){
        j=0;
        while(j<5){
            sum=sum+a[i][j];
            j=j+1;
        }
        i=i+1;
    }
    return sum;
}

/* 特性：
    函数
    变量声明（int、float、全局变量、局部变量）
    语句（if、while、return、语句块、赋值语句、表达式语句） 
    表达式
    

*/
/*求二维数组元素最大值*/                    
void maxfunc(float a[][5]){                 
    int i=0;
    int j;
    max=a[0][0];
    while(i<5){
        j=0;
        while(j<5){
            if(max<a[i][j]){
                max=a[i][j];
            }
            j=j+1;
        }
        i=i+1;
    }
    return;
}

/*
int、float
变量赋值、运算
局部变量和全局变量
数组
表达式
函数调用、函数无返回值、函数有返回值
注释
while
if

*/
int main(){
    printf("元素之和为：%f \n",sumfunc(a));
    maxfunc(a);
    printf("元素最大值为：%f \n",max);
    return 0;
}

/*
运行结果：
元素之和为：17.000000 
元素最大值为：5.000000 
*/