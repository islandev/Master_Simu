function [ fac ] = datafitting( ac )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [t,g]=size(ac);
    a0=[1,0.2,123456,1,17000,0.03];              %赋初值
    [A,resnorm,residual,exitflag,outpui]=lsqcurvefit(@myFCSJiaoZheng,a0,t,g);     %非线性拟合
    a0=A;
    [A,resnorm,residual,exitflag,outpui]=lsqcurvefit(@myFCSJiaoZheng,a0,t,g);     %二次非线性拟合
    a0=A;
    [A,resnorm,residual,exitflag,outpui]=lsqcurvefit(@myFCSJiaoZheng,a0,t,g);     %三次非线性拟合
    a0=A;
    [A,resnorm,residual,exitflag,outpui]=lsqcurvefit(@myFCSJiaoZheng,a0,t,g);     %四次非线性拟合
    SquChi=sum(residual.*residual);        %残差平方和
    DoF=1-2;                   %自由度
    AveChi=SquChi/DoF;               %平均剩余残差平方和
    Ydata=myFCSJiaoZheng(A,t)
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
    fac=A;
end

