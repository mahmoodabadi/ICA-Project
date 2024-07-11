function error=Alldatasets(in)
% number=2;
% if nargin<2
%     error('Name or Number of function is not specified.');
% end
% size(x,1)
warning('off')
load 'D:\University\TEZ implementation\mat files\clevhung.mat';


%view(t2)
% n=final;%[g,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13];
% x=eval(t2,n);
% k1=0;
% v=cellstr(class1);
% for i=1:length(x)
%     if x{i}==v{i}
%         k1=k1+1;
%     end
% end
% error_tree=1-(k1/(length(x)));

 for d=1:size(in,1);
indices = crossvalind('Kfold',class1,10);
for i=1:10

% for i = 1:10
    test = (indices == i); train = ~test;

final_test=final(find(test),:);
final_train=final(find(train),:);




    k=in(d,1:23); 
    w=in(d,24:46);


mf_array=[0.4 0.5463 0.6287; 0.5463 0.6287 0.6992;0.6287 0.6992 0.7287; 0.6992 0.7287 1;0 0.6835 0.7835;0.6835 0.7835 0.8835; 0.7835 0.8835 1;0 0.725 0.825; 0.725 0.825 0.925;0.825 0.925 1;0 0.1 0.22; 0.1 0.22 0.34; 0.22 0.34 1;0.029 0.190 0.306; 0.190 0.306 0.470; 0.306 0.470 0.65;0 0.224 0.424; 0.224 0.424 0.610;0.424 0.610 1;0 0.3550 0.4400;0.3550 0.4400 0.5275;0.4400 0.5275 0.6195;0.5275 0.6195 1];
%new_mfarray=[-1 0 1;1 2 3;2 3 4;94 120 146;120 146 172;172 185 200;1 2 3;2 3 4;3 4 5;2 4 5;5 6 7;6 7 8;-1 0 1;0 1 2;1 2 3;2 3 4;124 200 245;245 270 295;270 295 320;320 480 565;-1 0 0.9;0 0.9 1.35;1.35 5 7;70 110 152;110 152 192;180 192 202];
mf_max=1/30*[0.6287,0.6992,0.7287,1,0.7835,0.8835,1,0.825,0.925,1,0.22,0.34,1,0.306,0.470,0.65,0.424,0.610,1,0.4400,0.5275,0.6195,1];

for j=1:23
    shift_k(j,1)=mf_max(j)*k(j)-mf_max(j)*w(j);
    shift_k(j,2)=mf_max(j)*k(j);
    shift_k(j,3)=k(j)+w(j);
end

new_mfarray=mf_array+shift_k;



class_train=class1(find(train),:);


t = classregtree(final_train,class_train);
t2=prune(t,'level',9);
%view(t2)
n=final_train;%[g,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13];
x=eval(t2,n);
k1=0;
v=cellstr(class_train);
for j=1:length(x)
    if x{j}==v{j}
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



% final2=[g2,g4,g7,g9,g10,g11,g12,g13]';
final_test=final(find(test),:);
final1_test=final_test';


out1=evalfis(final1_test,sug_fismat);
class_test=class12(find(test),:);

 k1=0;
 tn=0;tp=0;fn=0;fp=0;
 for j=1:length(out1)
     
     if out1(j)<=0
         j1=0;
     else
         j1=1;
     end
   l=j1;
   if (l~=class_test(j))
       k1=k1+1;
   end
   if (l>0) && (class_test(j)>0)
      tp=tp+1;
   
%    elseif (l==1) && (class_test==0)
elseif (l>0) && (class_test(j)<=0)
           fn=fn+1;
       
%    elseif (l==0) && (class_test==1)
elseif (l<=0) && (class_test(j)>0)
       fp=fp+1;
%    elseif (l==0) && (class_test==0)
elseif (l<=0) && (class_test(j)<=0)
       tn=tn+1;
end

 end
 
 CM=[tp fp;fn tn]
length(class_test);
i
error111=(k1/length(final_test))
end
error(d,1)=mean(error111)
end
end

