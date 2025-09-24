global Lambda b1 b2 b3 b4 delta g  psi d... 
  sigma1 sigma2 sigma3 sigma4 gH dH...
l1 l2 p ...
bv1 bv2 bv3 bv4  deltav gv psiv ...
phi phiv1 phiv2 phiv3 phiv4 ...
N H  ...
%
close all

%Estacion 1: Semana Epidemiologica 1 a 13...   Verano
%Estacion 2: Semana Epidemiologica 14 a 26...  Oto?o 
%Estacion 3: Semana Epidemiologica 27 a 39...  Invierno 
%Estacion 4: Semana Epidemiologica 40 a 52...  Primvera 


N=1;%100000; %Poblacion
H=0.03;%9; %Capacidad de Carga Hospitalaria


Lambda=7*1/(78*52)*1; %Tasa de ingreso grupo riesgo 
d=7*1/(78*52)*1; %Tasa de salida grupo riesgo

b1=0.257*7; %0.9*2;%0.04*1;%0.11*5;%0.002*1; %tasa de trasmision 1
b2=0.424*7;%2.968*1;%1.7*1;%0.29*5;%0.7*1; %tasa de trasmision 2
b3=0.243*7;%1.7*1;%2.968*1;%0.56*5;%0.9*1; %tasa de trasmision 3
b4=0.202*7;%1.417*1;%0.417*1;%0.19*5;%0.001*1; %tasa de trasmision 4


delta=1/(4/7); %1/delta tiempo promedio incubacion
g=1/(10/7); %1/g tiempo promedio infeccioso
psi=1/(230/7); %1/psi tiempo promedio de inmunidad natural

sigma1=0.31;%0.64; %Tasa de Hospitalizacion por VRS
sigma2=0.19;%0.58; %Tasa de Hospitalizacion por VRS
sigma3=0.25;%0.55; %Tasa de Hospitalizacion por VRS
sigma4=0.26;%0.64; %Tasa de Hospitalizacion por VRS

gH=(1/8)*7; %1/gh tiempo promedio hospitalizado
dH=0.001*0; %Tasa de mortalidad por VRS

l1=0.03; %Tasa de resistencia al cambio
l2=0.09; %Velocidad de reaccionar
p=0.5; %Percepci?n del riesgo promedio


%vacuna
bv1=b1/8*1; %tasa de trasmision vacunados 1
bv2=b2/8*1; %tasa de trasmision vacunados 2
bv3=b3/8*1; %tasa de trasmision vacunados 3
bv4=b4/8*1; %tasa de trasmision vacunados 4


deltav=1/(4/7); %1/deltav tiempo promedio incubacion Vacunados
gv=1/(10/7); %1/gv tiempo promedio infeccioso vacunados
psiv=1/(230/7); %1/psiv tiempo promedio de inmunidad natural



phiv1=(7/120)*0.2*0*0; %Tasa de vacunaci?n
phiv2=(7/120)*0.2*1*10; %Tasa de vacunaci?n
phiv3=(7/120)*0.2*1/5*10; %Tasa de vacunaci?n
phiv4=(7/120)*0.2*0*0; %Tasa de vacunaci?n
phi=(1/180)*7; %1/phi Tiempo promedio de "inmunidad" por vacunaci?n



%PULSOS
a=0.0; %aumento en la percepci?n del riesgo



grid on



%X0 =  [S, Sc, E,  I, Ic,  Ih, H, R, P];
  %X0 = [0.99, 0.0, 0.01, 0.0, 0.0, 0.0, 0.0 , 0.0 , p];


  %X0 =  [S, E,  I, R,  H, Hc, Sv, Ev, Iv, Rv, p];
  X0 = [0.99999, 0.0, 0.00001, 0.0, 0.0, 0.0, 0.0 , 0.0, 0.0 , 0.0 , p];
  %X0 = [0.9999, 0.0, 0.00001, 0.0, 0.0, 0.0, 0.0 , 0.0, 0.0 , 0.0 , p];
  %  X0 = [99999, 0.0, 1, 0.0, 0.0, 0.0, 0.0 , 0.0, 0.0 , 0.0 , p];
  
  
  
TF = 500;



figure(1)
hold on
%for i = 1:1
    f1 = @(t,x) fR0VRS1(t,x);
    f2 = @(t,x) fR0VRS2(t,x);
    f3 = @(t,x) fR0VRS3(t,x);
    f4 = @(t,x) fR0VRS4(t,x);
   
   j=13; %largo del salto para estaciones/
   salto1=0;
   salto2=j;
   

  
   
  
      [t,y0{1}]=ode45(f1,[-0.0000000001,0],X0); 
      l0=length(y0{1,1}); 



for anual = 1:3%1:3

    
     for n = 1:4%1:4 
         
       
         
         if n==1  %Primera estacion (Enero a Marzo semanas epidemiologicas)
             
         
        a=0.1;

       X0pa0=[y0{1,1}(l0,1),y0{1,1}(l0,2), y0{1,1}(l0,3),y0{1,1}(l0,4),... 
              y0{1,1}(l0,5),y0{1,1}(l0,6),...
              y0{1,1}(l0,7),y0{1,1}(l0,8), y0{1,1}(l0,9),y0{1,1}(l0,10),...
              a+y0{1,1}(l0,11)];        
             
            
       [t,y0{1}]=ode45(f1,[salto1,salto2],X0pa0);
  
         salto1=salto1+j;
         salto2=salto2+j;
         l0=length(y0{1,1});

  
             
             
             
             
     elseif n==2 %Segunda periodo (abril a junio semanas epidemiologicas)
         
       a=0.0;  
       X0pa0=[y0{1,1}(l0,1),y0{1,1}(l0,2), y0{1,1}(l0,3),y0{1,1}(l0,4),... 
              y0{1,1}(l0,5),y0{1,1}(l0,6),...
              y0{1,1}(l0,7),y0{1,1}(l0,8), y0{1,1}(l0,9),y0{1,1}(l0,10),...
              a+y0{1,1}(l0,11)];     
             
            
       [t,y0{1}]=ode45(f2,[salto1,salto2],X0pa0);
  
         salto1=salto1+j;
         salto2=salto2+j;
         l0=length(y0{1,1});          
         
         
         
     elseif n==3 %Tercera periodo (julio a septiembre semanas epidemiologicas)
         
     a=0.0;    
     X0pa0=[y0{1,1}(l0,1),y0{1,1}(l0,2), y0{1,1}(l0,3),y0{1,1}(l0,4),... 
              y0{1,1}(l0,5),y0{1,1}(l0,6),...
              y0{1,1}(l0,7),y0{1,1}(l0,8), y0{1,1}(l0,9),y0{1,1}(l0,10),...
              a+y0{1,1}(l0,11)];     
      
             
            
       [t,y0{1}]=ode45(f3,[salto1,salto2],X0pa0);
  
         salto1=salto1+j;
         salto2=salto2+j;
         l0=length(y0{1,1});
      
      
         
               
         
     elseif n==4 %Cuarta periodo (octubre a diciembre semanas epidemiologicas)
         
     a=0.0;    
     X0pa0=[y0{1,1}(l0,1),y0{1,1}(l0,2), y0{1,1}(l0,3),y0{1,1}(l0,4),... 
              y0{1,1}(l0,5),y0{1,1}(l0,6),...
              y0{1,1}(l0,7),y0{1,1}(l0,8), y0{1,1}(l0,9),y0{1,1}(l0,10),...
              (1+a)*y0{1,1}(l0,11)];     
             
            
       [t,y0{1}]=ode45(f4,[salto1,salto2],X0pa0);
  
         salto1=salto1+j;
         salto2=salto2+j;
         l0=length(y0{1,1});   
         
         
         
         
        
        end
%   


    %


        %Casos con VRS (I+Iv+H+Hc)
     VRS=y0{1}(:,3)+y0{1}(:,5)+y0{1}(:,6)+y0{1}(:,9);
    plot(t,VRS,'linewidth',2,'color','c','LineStyle','-');


% Infectados (I+Iv)
     AI=y0{1}(:,3)+y0{1}(:,9);
    plot(t,AI,'linewidth',2,'color','r','LineStyle','-');






     %plot(t,y0{1}(:,1),'linewidth',2,'color','g','LineStyle','-')%S
    %plot(t,y0{1}(:,2),'linewidth',2,'color','b','LineStyle','-')%E
    % plot(t,y0{1}(:,3),'linewidth',2,'color','r','LineStyle','-')%I
    % plot(t,y0{1}(:,4),'linewidth',2,'color','g','LineStyle','-')%R

     plot(t,y0{1}(:,5),'linewidth',2,'color','b','LineStyle','-')%H   
     plot(t,y0{1}(:,6),'linewidth',2,'color','k','LineStyle','-')%Hc
   
    %plot(t,y0{1}(:,7),'linewidth',2,'color','g','LineStyle','-')%Sv
   %  plot(t,y0{1}(:,8),'linewidth',2,'color','r','LineStyle','--')%Ev
   % plot(t,y0{1}(:,9),'linewidth',2,'color','k','LineStyle','-')%Iv
   % plot(t,y0{1}(:,10),'linewidth',2,'color','b','LineStyle','-')%Rv

  %   plot(t,y0{1}(:,11),'linewidth',2,'color','r','LineStyle','-')%P




   
   
     
     
    %Infectados Totales(I+Ic+Iv+Ivc)
     %AItotal=y0{1}(:,4)+y0{1}(:,5)+y0{1}(:,12)+y0{1}(:,13);
   % plot(t,AItotal,'linewidth',2,'color','c','LineStyle','-'); 
     

%     
%     
     end
% 
%

xline(52);
xline(104);
xline(156);


end   
%     
%     
%     
%     
%     
%     
% % %linea vertical
% % exis=360;
% % igriega1=0;
% % igriega2=1;
% % plot([exis, exis], [igriega1, igriega2],'linewidth',1,'color',[1,0.5,1],'LineStyle','--')
% % 
% % 
% % 
% % exis2=720;
% % igriega1=0;
% % igriega2=1;
% % plot([exis2, exis2], [igriega1, igriega2],'linewidth',1,'color',[1,0.5,1],'LineStyle','--')
% % 
% 
%     

%xlim([0 1080])
%ylim([0 600])
%ylim([0 10])

 xlabel('Time (Epidemiological week)');
 ylabel('Population');
 % xlabel('Time (Days)');
% ylabel('Stone fruit trees');
%ylabel('Infected Grapevines');
% %ylabel('Collateral effect');  
% 
% 
%xticks([0 30 60 90 120 150 180])
%xticks([0 90 180 270 360])
%xticks([0 90 180 270 360 450 540 630 720])
xticks([0 13 26 39 52 65 78 91 104 117 130 143 156])
%xticks([0  180 360 540 720 900 1080])
%xticklabels({'0', '12' ,'24', '36', '48', '60', '72', '84', '96', '108'})
% %xticks([0 7 14 21 28 35])
% %xticklabels({'0','30','60','90','120'})
% 
legend('VRS cases','Infectious','Hospitalized','Hospital collapse')
%legend('E_G + I_G')
%legend('V_l','V_L','V_A','V_1','V_2','V_3','F','C_l','C_A','V')
% %legend('Intoxicated','Health effects')
% %legend('K_p','K_o','K_c')
% %legend('S_c', 'D_c')
% %legend('S_v^m', 'S_v^l', 'I_v^m', 'I_v^l')
% 
 grid on
 box on
%     
