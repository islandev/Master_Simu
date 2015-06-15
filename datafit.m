%拟合过程如下：1、将FCSfitJiaoZheng、myFCSJiaoZheng的m文件拷贝到待拟合数据（sin格式）所在的文件夹下,全部打开；
             %2、赋初值，在本程序的第14行
             %3、点击工具栏中间的绿色小箭头运行即可，或快捷键F5
clear all;clc;
programstarttime=clock;  %系统时间
format long;   %定义数值输出精度
filename=dir('*.mat');   %获取文件夹下所有mat格式文件的信息
[numfile,~]=size(filename);  %获取文件数目
for ii=1:numfile
    name=filename(ii).name;    %当下循环拟合的文件名
    [t,g]=textread(name,'%f %f',796,'headerlines',87);%导入数据
    t=load
    [numdata,~]=size(t);
    %在下一行赋初值，依次为：c,a,b,N,D,S
    [t,g]=size(t);
    a0=[1,0.2,123456,1,17000,0.03];              %赋初值
    [A,resnorm,residual,exitflag,outpui]=lsqcurvefit(@myFCSJiaoZheng,a0,t,g);     %非线性拟合
    a0=A;
    [A,resnorm,residual,exitflag,outpui]=lsqcurvefit(@myFCSJiaoZheng,a0,t,g);     %二次非线性拟合
    a0=A;
    [A,resnorm,residual,exitflag,outpui]=lsqcurvefit(@myFCSJiaoZheng,a0,t,g);     %三次非线性拟合
    a0=A;
    [A,resnorm,residual,exitflag,outpui]=lsqcurvefit(@myFCSJiaoZheng,a0,t,g);     %四次非线性拟合
    SquChi=sum(residual.*residual);        %残差平方和
    DoF=numdata-2;                   %自由度
    AveChi=SquChi/DoF;               %平均剩余残差平方和
    Ydata=myFCSJiaoZheng(A,t);      %拟合所得曲线
    R=corrcoef(g,Ydata);SquR=(R(1,2))^2;         %相关系数
    c=num2str(A(1));a=num2str(A(2));b=num2str(A(3));N=num2str(A(4));D=num2str(A(5));S=num2str(A(6));  %提取拟合结果
    strAveChi=num2str(AveChi);strSquR=num2str(SquR);   %拟合指标
    lable1={'c';'a';'b';'N';'D';'S';'Chi^2/DoF';'R^2'};   %编辑图标
    lable2={c;a;b;N;D;S;strAveChi;strSquR};
    figure;   %开始画图命令
    h=semilogx(t,g,'k.',t,Ydata,'r-');    %x为对数坐标画图
    text(0.004*max(t),0.95*max(g),lable1);     %显示拟合结果
    text(0.045*max(t),0.95*max(g),lable2);
    xlabel('delaytime/s');ylabel('G');    %编辑坐标轴名
    figure_FontSize=11;                 %修改字体
    set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
    set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
    set(findobj('FontSize',10),'FontSize',figure_FontSize);
    set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);  %修改线宽
    Name=[name,'.','jpeg'];   %编辑图像名称
    print(gcf,'-djpeg',Name);   %保存图像
    close(gcf);
    if ii==1          
        Lable1={'name';'c';'a';'b';'N';'D';'S';'Chi^2/DoF';'R^2'};    %excel表头
        Lable2={name;c;a;b;N;D;S;strAveChi;strSquR};
        Lable=[Lable1,Lable2]';
        Range=['A',num2str(ii)];
        xlswrite('fitResults.xls',Lable,'fitResults',Range);   %将拟合结果保存至Excel文档
    end
    if ii>1          %保存拟合结果
        Lable={name;c;a;b;N;D;S;strAveChi;strSquR}';
        Range=['A',num2str(ii+1)];
        xlswrite('fitResults.xls',Lable,'fitResults',Range);
    end
end
elapsedtime = etime(clock, programstarttime);   %拟合耗用的时间

