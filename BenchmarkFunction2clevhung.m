function error=BenchmarkFunction2clevhung(in)
% number=2;
% if nargin<2
%     error('Name or Number of function is not specified.');
% end
% size(x,1)
warning('off')
 

% mf_array=[0.4 0.5463 0.6287; 0.5463 0.6287 0.6992;0.6287 0.6992 0.7287; 0.6992 0.7287 1;0 0.6835 0.7835;0.6835 0.7835 0.8835; 0.7835 0.8835 1;0 0.725 0.825; 0.725 0.825 0.925;0.825 0.925 1;0 0.1 0.22; 0.1 0.22 0.34; 0.22 0.34 1;0.029 0.190 0.306; 0.190 0.306 0.470; 0.306 0.470 0.65;0 0.224 0.424; 0.224 0.424 0.610;0.424 0.610 1;0 0.3550 0.4400;0.3550 0.4400 0.5275;0.4400 0.5275 0.6195;0.5275 0.6195 1];
% %new_mfarray=[-1 0 1;1 2 3;2 3 4;94 120 146;120 146 172;172 185 200;1 2 3;2 3 4;3 4 5;2 4 5;5 6 7;6 7 8;-1 0 1;0 1 2;1 2 3;2 3 4;124 200 245;245 270 295;270 295 320;320 480 565;-1 0 0.9;0 0.9 1.35;1.35 5 7;70 110 152;110 152 192;180 192 202];
% mf_max=1/30*[0.6287,0.6992,0.7287,1,0.7835,0.8835,1,0.825,0.925,1,0.22,0.34,1,0.306,0.470,0.65,0.424,0.610,1,0.4400,0.5275,0.6195,1];
in=zeros(1,46);
Alldatasets(in);
hold on;
in=[0.201	0.123	0.890	0.464	1.000	0.067	0.255	1.000	0.384	0.000	0.915	0.426	0.000	0.617	0.569	0.000	0.985	0.177	0.880	0.550	0.680	0.000	0.592	0.000	0.010	0.722	0.529	0.000	0.095	1.000	0.000	0.705	0.321	1.000	0.933	0.145	0.931	0.000	0.328	0.000	0.614	0.507	1.000	0.348	0.357	0.476]
Alldatasets(in);

fismat = readfis('D:\University\Tez\implementation\myfile');
sug_fismat = mam2sug(fismat);
  
plotmf(fismat,'input',1);
hold off;



fismat = readfis('D:\University\Tez\implementation\myfile');
sug_fismat = mam2sug(fismat);
  
plotmf(fismat,'input',1);
hold on;
plotmf(fismat,'input',1);



 
 for d=1:size(in,1);

    k=in(d,1:23); 
    w=in(d,24:46);


mf_array=[0.4 0.5463 0.6287; 0.5463 0.6287 0.6992;0.6287 0.6992 0.7287; 0.6992 0.7287 1;0 0.6835 0.7835;0.6835 0.7835 0.8835; 0.7835 0.8835 1;0 0.725 0.825; 0.725 0.825 0.925;0.825 0.925 1;0 0.1 0.22; 0.1 0.22 0.34; 0.22 0.34 1;0.029 0.190 0.306; 0.190 0.306 0.470; 0.306 0.470 0.65;0 0.224 0.424; 0.224 0.424 0.610;0.424 0.610 1;0 0.3550 0.4400;0.3550 0.4400 0.5275;0.4400 0.5275 0.6195;0.5275 0.6195 1];
%new_mfarray=[-1 0 1;1 2 3;2 3 4;94 120 146;120 146 172;172 185 200;1 2 3;2 3 4;3 4 5;2 4 5;5 6 7;6 7 8;-1 0 1;0 1 2;1 2 3;2 3 4;124 200 245;245 270 295;270 295 320;320 480 565;-1 0 0.9;0 0.9 1.35;1.35 5 7;70 110 152;110 152 192;180 192 202];
mf_max=1/30*[0.6287,0.6992,0.7287,1,0.7835,0.8835,1,0.825,0.925,1,0.22,0.34,1,0.306,0.470,0.65,0.424,0.610,1,0.4400,0.5275,0.6195,1];

for i=1:23
    shift_k(i,1)=mf_max(i)*k(i)-mf_max(i)*w(i);
    shift_k(i,2)=mf_max(i)*k(i);
    shift_k(i,3)=k(i)+w(i);
end

new_mfarray=mf_array+shift_k;




load 'D:\University\TEZ implementation\mat files\clevhung.mat';


train_set=final(1:468,:);

class_train=class1(1:468);
t = classregtree(train_set,class_train);
t2=prune(t,'level',7);
% view(t2)
n=train_set;
x=eval(t2,n);
k1=0;
v=cellstr(class_train);
for i=1:length(x)
    if x{i}==v{i}
        k1=k1+1;
    end
end
error_tree=1-(k1/(length(x)));






a = newfis('heart');



%...................................................input1=trestbps
a = addvar(a,'input','trestbps',[0.4 1]);

a = addmf(a,'input',1,'low','trimf',new_mfarray(1,:));
a = addmf(a,'input',1,'medium','trimf',new_mfarray(2,:));
a = addmf(a,'input',1,'high','trimf',new_mfarray(3,:));
a = addmf(a,'input',1,'veryhigh','trimf',new_mfarray(4,:));

%...................................................input2=cp

a = addvar(a,'input','cp',[0 1]);

a = addmf(a,'input',2,'low','trimf',new_mfarray(5,:));
a = addmf(a,'input',2,'low','trimf',new_mfarray(6,:));
a = addmf(a,'input',2,'medium','trimf',new_mfarray(7,:));

%....................................................input3=thal
a = addvar(a,'input','thal',[0 1]);

a = addmf(a,'input',3,'low','trimf',new_mfarray(8,:));
a = addmf(a,'input',3,'medium','trimf',new_mfarray(9,:));
a = addmf(a,'input',3,'high','trimf',new_mfarray(10,:));


%..................................................input4=ca
a = addvar(a,'input','ca',[0 1]);

a = addmf(a,'input',4,'low','trimf',new_mfarray(11,:));
a = addmf(a,'input',4,'medium','trimf',new_mfarray(12,:));
a = addmf(a,'input',4,'high','trimf',new_mfarray(13,:));


%...................................................input5=chol
a = addvar(a,'input','chol',[0.0290 0.6410]);

a = addmf(a,'input',5,'low','trimf',new_mfarray(14,:));
a = addmf(a,'input',5,'medium','trimf',new_mfarray(15,:));
a = addmf(a,'input',5,'high','trimf',new_mfarray(16,:));


%....................................................input6=oldpeak
a = addvar(a,'input','oldpeak',[0 1]);

a = addmf(a,'input',6,'low','trimf',new_mfarray(17,:));
a = addmf(a,'input',6,'medium','trimf',new_mfarray(18,:));
a = addmf(a,'input',6,'high','trimf',new_mfarray(19,:));
%....................................................input7=thalach
a = addvar(a,'input','thalach',[0 1]);

a = addmf(a,'input',7,'low','trimf',new_mfarray(20,:));
a = addmf(a,'input',7,'medium','trimf',new_mfarray(21,:));
a = addmf(a,'input',7,'high','trimf',new_mfarray(22,:));
a = addmf(a,'input',7,'high','trimf',new_mfarray(23,:));












%................................................output
 
a = addvar(a,'output','determination',[-1 1]);
a = addmf(a,'output',1,'A','trapmf',[-20 -3 -0.5 0.5]);
a = addmf(a,'output',1,'B','trapmf',[0.5 1 4 20]);
% a = addmf(a,'output',1,'C','trimf',[1.5 2 2.5]);
% a = addmf(a,'output',1,'D','trimf',[2.5 3 3.5]);
% a = addmf(a,'output',1,'E','trimf',[3.5 4 4.5]);

%.................................................


ruleList=[
0 3 0 2 0 0 0 2 1 1
0 3 2 1 0 0 0 1 1 1
0 3 3 1 0 0 0 2 1 1
0 2 0 2 0 3 0 2 1 1
0 2 0 1 0 3 0 1 1 1
0 2 0 0 0 2 4 1 1 1
0 2 0 0 1 2 3 1 1 1
0 2 0 0 2 1 3 1 1 1
2 2 0 0 2 2 3 2 1 1
3 2 0 0 2 2 3 1 1 1
4 2 0 0 2 2 2 2 1 1
3 2 0 0 2 2 1 2 1 1
1 2 0 0 2 2 2 2 1 1
2 2 0 0 2 2 2 1 1 1
];

a = addrule(a,ruleList);
% showrule(a,[1 2 3 4 5 6 7 8  9 10 11 12],'symbolic')
  
writefis(a,'D:\University\Tez\implementation\myfile');
fismat = readfis('D:\University\Tez\implementation\myfile');


sug_fismat = mam2sug(fismat);



final2=final(469:587,:);
final_test=final2';

 
out1=evalfis(final_test,sug_fismat);

class_test=class12(469:587);


 k1=0;
 for i=1:length(out1)
     
     if out1(i)<=0
         j1=0;
     else
         j1=1;
     end
   l=j1;
   if (l~=class_test(i))
       k1=k1+1;
   end
  
   
end
error(d,1)=(k1/length(final_test));
end
end


