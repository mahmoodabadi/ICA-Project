clc;
clear;
load 'C:\Users\Zahra\Desktop\matlab1.mat';
  t = classregtree([g,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13],class1);
  view(t);
 
 n=[g,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13];
x=eval(t,n);

k1=0;
v=cellstr(class1);
for i=1:length(x)
    if x{i}==v{i}
        k1=k1+1;
    end
end
error_tree=1-(k1/(length(x)))

a = newfis('heart');
%...................................................input1=gender
a = addvar(a,'input','gender',[-1 2]);

a = addmf(a,'input',1,'s2','trimf',[-0.95 0 0.95]);
a = addmf(a,'input',1,'l3','trimf',[0.95 1 1.95]);
...................................................input2=slope

a = addvar(a,'input','slope',[-1 4]);

a = addmf(a,'input',2,'s3','trimf',[-1 0 1]);
a = addmf(a,'input',2,'m3','trimf',[1 2 3]);
a = addmf(a,'input',2,'l3','trimf',[2 3 4]);

% %..................................................input3=age
a = addvar(a,'input','age',[0 78]);
a = addmf(a,'input',3,'low','trimf',[0 25 34]);
a = addmf(a,'input',3,'Medium','trimf',[30 35 39]);
a = addmf(a,'input',3,'old','trimf',[40 49 58]);
a = addmf(a,'input',3,'very old','trimf',[52 65 77]);
%...................................................input4=trestbps
a = addvar(a,'input','trestbps',[94 200]);

a = addmf(a,'input',4,'low','trimf',[94 115 130]);
a = addmf(a,'input',4,'medium','trimf',[125 145 155]);
a = addmf(a,'input',4,'high','trimf',[150 165 175]);
a = addmf(a,'input',4,'very high','trimf',[170 185 200]);
%...................................................input5=fbs

a = addvar(a,'input','fbs',[-1 2]);



a = addmf(a,'input',5,'low','trimf',[-0.95 0 0.95]);
a = addmf(a,'input',5,'high','trimf',[0.95 1 1.95]);



%...................................................input6=exang
a = addvar(a,'input','exang',[-1 2]);



a = addmf(a,'input',6,'low','trimf',[-0.95 0 0.95]);
a = addmf(a,'input',6,'high','trimf',[0.95 1 1.95]);


%...................................................input7=cp

a = addvar(a,'input','cp',[-1 5]);

a = addmf(a,'input',7,'low','trimf',[-1 0 1]);
a = addmf(a,'input',7,'medium','trimf',[1 2 3]);
a = addmf(a,'input',7,'high','trimf',[3 4 5]);


%...................................................input8=resteg

a = addvar(a,'input','resteg',[-1 3]);

a = addmf(a,'input',8,'low','trimf',[-1 0 0.5]);
a = addmf(a,'input',8,'medium','trimf',[0.5 1 1.5]);
a = addmf(a,'input',8,'high','trimf',[1.5 2 3]);

%....................................................input9=thal
a = addvar(a,'input','thal',[2 7]);

a = addmf(a,'input',9,'low','trimf',[2 3 3.5]);
a = addmf(a,'input',9,'medium','trimf',[3.5 4 6]);
a = addmf(a,'input',9,'high','trimf',[4 6 7]);


%..................................................input10=ca
a = addvar(a,'input','ca',[-1 4]);

a = addmf(a,'input',10,'low','trimf',[-1 0 0.5]);
a = addmf(a,'input',10,'medium','trimf',[0.5 1 1.5]);
a = addmf(a,'input',10,'high','trimf',[1.5 2 2.5]);
a = addmf(a,'input',10,'very high','trimf',[2.5 3 3.5]);

%...................................................input11=chol
a = addvar(a,'input','chol',[124 565]);

a = addmf(a,'input',11,'low','trimf',[124 180 225]);
a = addmf(a,'input',11,'medium','trimf',[220 280 320]);
a = addmf(a,'input',11,'high','trimf',[300 380 460]);
a = addmf(a,'input',11,'very high','trimf',[400 480 565]);

%....................................................input12=oldpeak
a = addvar(a,'input','oldpeak',[0 8]);

a = addmf(a,'input',12,'low','trimf',[0 2 4]);
a = addmf(a,'input',12,'high','trimf',[2.5 5 7]);
%....................................................input13=thalach
a = addvar(a,'input','thalach',[70 202]);

a = addmf(a,'input',13,'low','trimf',[70 85 100]);
a = addmf(a,'input',13,'medium','trimf',[90 130 150]);
a = addmf(a,'input',13,'high','trimf',[140 160 180]);
a = addmf(a,'input',13,'very high','trimf',[170 185 203]);

%................................................output
 
a = addvar(a,'output','determination',[-1 5]);
a = addmf(a,'output',1,'A','trimf',[-1 0 0.5]);
a = addmf(a,'output',1,'B','trimf',[0.5 1 1.5]);
a = addmf(a,'output',1,'C','trimf',[1.5 2 2.5]);
a = addmf(a,'output',1,'D','trimf',[2.5 3 3.5]);
a = addmf(a,'output',1,'E','trimf',[3.5 4 4.5]);

%.................................................


ruleList=[
0 0 0 0 0 0 3 0 0 1 0 0 0 3 1 1
0 0 0 0 0 0 3 0 3 1 2 1 0 1 1 1
0 0 0 0 0 0 3 0 3 1 2 2 0 4 1 1
% 0 2 0 8 0 0 3 0 0 2 0 0 0 4 1 1
% 0 0 0 7 0 0 3 0 0 2 0 0 8 5 1 1
0 2 0 2 0 0 3 0 0 2 0 0 0 4 1 1
0 0 0 2 0 0 3 0 0 4 0 0 2 5 1 1
0 0 0 0 0 0 2 2 3 2 0 0 2 2 1 1
0 0 0 0 0 0 2 0 2 2 0 0 2 3 1 1
];

a = addrule(a,ruleList);
  

writefis(a,'D:\University\Tez\implementation\myfile');
fismat = readfis('D:\University\Tez\implementation\myfile');
  
out=evalfis(final1,fismat);
 k=0;
  k1=0;
 for i=1:length(out)
     j1=round(out(i));
   if (j1<0)
       j1=0;
   elseif (j1>4)
       j1=4;
   
   end
   l=j1;
   if (l~=class4(i))
       
       k1=k1+1;
   end
  
   
end
error=(k1/303)
 
 
%  for i=1:303
%     l= round(out(i)); 
%    
%    if (l~=round(class1(i)))
%        
%        k=k+1;
%    end
%    
%        
%    
% end
% error=(k/303)