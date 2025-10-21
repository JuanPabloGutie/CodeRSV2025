global Lambda b1 b2 b3 b4 delta g  psi d... 
  sigma1 sigma2 sigma3 sigma4 gH dH...
l1 l2 p ...
bv1 bv2 bv3 bv4  deltav gv psiv ...
phi phiv1 phiv2 phiv3 phiv4 ...
N H  ...
%
close all

%Station 1: Epidemiological Week 1 to 13...   
%Station 2: Epidemiological Week 14 to 26...   
%Station 3: Epidemiological Week 27 to 39...  
%Station 4: Epidemiological Week 40 to 52...   


N=1;%100000; %Population
H=0.03;%9; %Hospital Capacity


Lambda=1/728; %Risk group admission rate
d=1/728; %Risk group exit rate

b1=0.257*7; %0.9*2;%0.04*1;%0.11*5;%0.002*1; %Transmission rate 1
b2=0.424*7;%2.968*1;%1.7*1;%0.29*5;%0.7*1; %Transmission rate 2
b3=0.243*7;%1.7*1;%2.968*1;%0.56*5;%0.9*1; %tTransmission rate 3
b4=0.202*7;%1.417*1;%0.417*1;%0.19*5;%0.001*1; %Transmission rate 4


ddelta=1/(4/7); %1/delta average latency time
g=1/(10/7); %1/g average infectious time
psi=1/(230/7); %1/psi average time of natural immunity

sigma1=0.31;%0.64; %RSV Hospitalization Rate1
sigma2=0.19;%0.58; %RSV Hospitalization Rate2
sigma3=0.25;%0.55; %RSV Hospitalization Rate3
sigma4=0.26;%0.64; %RSV Hospitalization Rate3

gH=(1/8)*7; %1/gh average hospital stay
dH=0.001*0; %RSV mortality rate

l1=0.03; %Rate of resistance to change
l2=0.09; %Reaction speed
p=0.5; %Average risk perception


%vacuna
bv1=b1/8*1; %vaccinated transmission rate 1
bv2=b2/8*1; %vaccinated transmission rate 2
bv3=b3/8*1; %vaccinated transmission rate 3
bv4=b4/8*1; %vaccinated transmission rate 4


deltav=1/(4/7); %1/deltav average incubation time vaccinated
gv=1/(10/7); %1/gv average infectious time vaccinated
psiv=1/(230/7); %1/psiv average time of natural immunity



phiv1=(7/120)*0.2*0*0; %Vaccination rate 1
phiv2=(7/120)*0.2*1*10; %Vaccination rate 2
phiv3=(7/120)*0.2*1/5*10; %Vaccination rate 3
phiv4=(7/120)*0.2*0*0; %Vaccination rate 4
phi=(1/180)*7; %1/phi Average time of "immunity" per vaccination



a=0.0; %increased risk perception



grid on



%X0 =  [S, Sc, E,  I, Ic,  Ih, H, R, P];
  %X0 = [0.99, 0.0, 0.01, 0.0, 0.0, 0.0, 0.0 , 0.0 , p];


  %X0 =  [S, E,  I, R,  H, Hc, Sv, Ev, Iv, Rv, p];
  %X0 = [0.9999, 0.0, 0.00001, 0.0, 0.0, 0.0, 0.0 , 0.0, 0.0 , 0.0 , p];
%X0 = [0.99999, 0.0, 0.00001, 0.0, 0.0, 0.0, 0.0 , 0.0, 0.0 , 0.0 , p];
%X0 = [0.99991, 0.0, 0.00009, 0.0, 0.0, 0.0, 0.0 , 0.0, 0.0 , 0.0 , p];
X0 = [0.99901, 0.0, 0.00099, 0.0, 0.0, 0.0, 0.0 , 0.0, 0.0 , 0.0 , p];
%X0 = [0.99001, 0.0, 0.00999, 0.0, 0.0, 0.0, 0.0 , 0.0, 0.0 , 0.0 , p];
%X0 = [0.90001, 0.0, 0.09999, 0.0, 0.0, 0.0, 0.0 , 0.0, 0.0 , 0.0 , p];
%X0 = [0.00001, 0.0, 0.99999, 0.0, 0.0, 0.0, 0.0 , 0.0, 0.0 , 0.0 , p];
  %  X0 = [99999, 0.0, 1, 0.0, 0.0, 0.0, 0.0 , 0.0, 0.0 , 0.0 , p];
  
  
  
TF = 500;



figure(1)
hold on
%for i = 1:1
    f1 = @(t,x) fR0VRS1(t,x);
    f2 = @(t,x) fR0VRS2(t,x);
    f3 = @(t,x) fR0VRS3(t,x);
    f4 = @(t,x) fR0VRS4(t,x);
   
   j=13; %jump length for stations
   salto1=0;
   salto2=j;
   

  
   
  
      [t,y0{1}]=ode45(f1,[-0.0000000001,0],X0); 
      l0=length(y0{1,1}); 



for anual = 1:9%1:3

    
     for n = 1:4%1:4 
         
       
         
         if n==1  %First period
             
         
        a=0.1;

       X0pa0=[y0{1,1}(l0,1),y0{1,1}(l0,2), y0{1,1}(l0,3),y0{1,1}(l0,4),... 
              y0{1,1}(l0,5),y0{1,1}(l0,6),...
              y0{1,1}(l0,7),y0{1,1}(l0,8), y0{1,1}(l0,9),y0{1,1}(l0,10),...
              a+y0{1,1}(l0,11)];        
             
            
       [t,y0{1}]=ode45(f1,[salto1,salto2],X0pa0);
  
         salto1=salto1+j;
         salto2=salto2+j;
         l0=length(y0{1,1});

  
             
             
             
             
     elseif n==2 %Second period
         
       a=0.0;  
       X0pa0=[y0{1,1}(l0,1),y0{1,1}(l0,2), y0{1,1}(l0,3),y0{1,1}(l0,4),... 
              y0{1,1}(l0,5),y0{1,1}(l0,6),...
              y0{1,1}(l0,7),y0{1,1}(l0,8), y0{1,1}(l0,9),y0{1,1}(l0,10),...
              a+y0{1,1}(l0,11)];     
             
            
       [t,y0{1}]=ode45(f2,[salto1,salto2],X0pa0);
  
         salto1=salto1+j;
         salto2=salto2+j;
         l0=length(y0{1,1});          
         
         
         
     elseif n==3 %Third period
         
     a=0.0;    
     X0pa0=[y0{1,1}(l0,1),y0{1,1}(l0,2), y0{1,1}(l0,3),y0{1,1}(l0,4),... 
              y0{1,1}(l0,5),y0{1,1}(l0,6),...
              y0{1,1}(l0,7),y0{1,1}(l0,8), y0{1,1}(l0,9),y0{1,1}(l0,10),...
              a+y0{1,1}(l0,11)];     
      
             
            
       [t,y0{1}]=ode45(f3,[salto1,salto2],X0pa0);
  
         salto1=salto1+j;
         salto2=salto2+j;
         l0=length(y0{1,1});
      
      
         
               
         
     elseif n==4 %Fourth period
         
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


        %Cases with RSV (I+Iv+H+Hc)
     VRS=y0{1}(:,3)+y0{1}(:,5)+y0{1}(:,6)+y0{1}(:,9);
    plot(t,VRS,'linewidth',2,'color','c','LineStyle','-');


% Infectious (I+Iv)
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




   
   
     
     
    %Infectious total(I+Ic+Iv+Ivc)
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
xline(208);
xline(262);
xline(314);
xline(366);
xline(418);
xline(470);


end   


 xlabel('Time (Epidemiological week)');
 ylabel('Population');

%xticks([0 13 26 39 52 65 78 91 104 117 130 143 156])
xticks([0 52 104 156 208 262 314 366 418 470])

% 
legend('RSV cases','Infectious','Hospitalized','Hospital collapse')
%legend('E_G + I_G')

% 
 grid on
 box on
%     
