function error=breast(in)
% number=2;
% if nargin<2
%     error('Name or Number of function is not specified.');
% end
% size(x,1)
warning('off')
load 'D:\University\TEZ implementation\mat files\Breast.mat';

t = classregtree(final,class1);
t2=prune(t,'level',0);
%view(t2)
n=final;%[g,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13];
x=eval(t2,n);
k1=0;
v=cellstr(class1);
for i=1:length(x)
    if x{i}==v{i}
        k1=k1+1;
    end
end
error_tree=1-(k1/(length(x)));


indices = crossvalind('Kfold',class1,10);
for i=1:10

% for i = 1:10
    test = (indices == i); train = ~test;

final_test=final(find(test),:);
final_train=final(find(train),:);


 for d=1:size(in,1);

    k=in(d,1:29); 
    w=in(d,30:58);


mf_array=[0 0.450 0.550; 0.450 0.550 0.650; 0.550 0.650 0.750; 0.650 0.750 1;-0.134 0.066 0.266;0.066 0.266 0.510; 0.266 0.510 0.754; 0.510 0.754 1;-0.134 0.066 0.266; 0.066 0.266 0.666; 0.266 0.666 1;0 0.177 0.377; 0.177 0.377 0.577; 0.377 0.577 0.777; 0.577 0.777 1; -0.134 0.066 0.266; 0.066 0.266 0.466; 0.266 0.466 0.666; 0.466 0.666 0.866; 0.666 0.866 1.066; 0 0.177 0.377; 0.177 0.377 0.577; 0.377 0.577 0.777; 0.577 0.777 1; 0 0.392 0.524; 0.392 0.524 0.656; 0.524 0.656 0.788; 0.656 0.788 0.988; 0.788 0.988 1.088];
%new_mfarray=[-1 0 1;1 2 3;2 3 4;94 120 146;120 146 172;172 185 200;1 2 3;2 3 4;3 4 5;2 4 5;5 6 7;6 7 8;-1 0 1;0 1 2;1 2 3;2 3 4;124 200 245;245 270 295;270 295 320;320 480 565;-1 0 0.9;0 0.9 1.35;1.35 5 7;70 110 152;110 152 192;180 192 202];
mf_max=1/30*[0.550,0.650,0.750,1,0.266,0.510,0.754,1,0.266,0.666,1,0.377,0.577,0.777,1,0.266,0.466,0.666,0.866,1.066,0.377 0.577,0.777,1,0.524 0.656,0.788,0.988,1.088];

for i=1:29
    shift_k(i,1)=mf_max(i)*k(i)-mf_max(i)*w(i);
    shift_k(i,2)=mf_max(i)*k(i);
    shift_k(i,3)=k(i)+w(i);
end

new_mfarray=mf_array+shift_k;



class_train=class1(find(train),:);

% 
% t = classregtree(final_train,class_train);
% t2=prune(t,'level',0);
% view(t2)
% n=final_train;%[g,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13];
% x=eval(t2,n);
% k1=0;
% v=cellstr(class_train);
% for i=1:length(x)
%     if x{i}==v{i}
%         k1=k1+1;
%     end
% end
% error_tree=1-(k1/(length(x)));



a = newfis('breast');



%...................................................input1=clump
a = addvar(a,'input','clump',[0 1]);

a = addmf(a,'input',1,'low','trimf',new_mfarray(1,:));
a = addmf(a,'input',1,'medium','trimf',new_mfarray(2,:));
a = addmf(a,'input',1,'high','trimf',new_mfarray(3,:));
a = addmf(a,'input',1,'high1','trimf',new_mfarray(4,:));


%...................................................input2=Uni1

a = addvar(a,'input','Uni1',[-0.134 1]);

a = addmf(a,'input',2,'low','trimf',new_mfarray(5,:));
a = addmf(a,'input',2,'medium','trimf',new_mfarray(6,:));
a = addmf(a,'input',2,'high','trimf',new_mfarray(7,:));
a = addmf(a,'input',2,'high1','trimf',new_mfarray(8,:));

%....................................................input3=Uni2
a = addvar(a,'input','Uni2',[0 1]);

a = addmf(a,'input',3,'low','trimf',new_mfarray(9,:));
a = addmf(a,'input',3,'medium','trimf',new_mfarray(10,:));
a = addmf(a,'input',3,'high','trimf',new_mfarray(11,:));


%..................................................input4=Marginal
a = addvar(a,'input','Marginal',[0 1]);

a = addmf(a,'input',4,'low','trimf',new_mfarray(12,:));
a = addmf(a,'input',4,'medium','trimf',new_mfarray(13,:));
a = addmf(a,'input',4,'high','trimf',new_mfarray(14,:));
a = addmf(a,'input',4,'high','trimf',new_mfarray(15,:));


%....................................................input6=Bare
a = addvar(a,'input','Bare',[-0.134 1.066]);

a = addmf(a,'input',5,'low','trimf',new_mfarray(16,:));
a = addmf(a,'input',5,'medium','trimf',new_mfarray(17,:));
a = addmf(a,'input',5,'high','trimf',new_mfarray(18,:));
a = addmf(a,'input',5,'high11','trimf',new_mfarray(19,:));
a = addmf(a,'input',5,'high22','trimf',new_mfarray(20,:));
%....................................................input7=Bland
a = addvar(a,'input','Bland',[0 1]);

a = addmf(a,'input',6,'low','trimf',new_mfarray(21,:));
a = addmf(a,'input',6,'medium','trimf',new_mfarray(22,:));
a = addmf(a,'input',6,'high','trimf',new_mfarray(23,:));
a = addmf(a,'input',6,'high2','trimf',new_mfarray(24,:));
%....................................................input8=Normal
a = addvar(a,'input','Normal',[0 1.088]);

a = addmf(a,'input',7,'low','trimf',new_mfarray(25,:));
a = addmf(a,'input',7,'medium','trimf',new_mfarray(26,:));
a = addmf(a,'input',7,'high','trimf',new_mfarray(27,:));
a = addmf(a,'input',7,'high3','trimf',new_mfarray(28,:));
a = addmf(a,'input',7,'high4','trimf',new_mfarray(29,:));


%................................................output
 
a = addvar(a,'output','determination',[-1 1]);
a = addmf(a,'output',1,'A','trapmf',[-20 -3 -0.5 0.5]);
a = addmf(a,'output',1,'B','trapmf',[0.5 1 4 20]);
% a = addmf(a,'output',1,'C','trimf',[1.5 2 2.5]);
% a = addmf(a,'output',1,'D','trimf',[2.5 3 3.5]);
% a = addmf(a,'output',1,'E','trimf',[3.5 4 4.5]);

%.................................................


ruleList=[
3 1 0 0 3 0 0 2 1 1
0 1 0 0 4 0 0 2 1 1
2 1 0 0 3 0 4 1 1 1
2 1 0 0 3 0 5 2 1 1
0 3 2 0 0 0 0 2 1 1
3 2 2 0 2 0 0 2 1 1
2 2 2 0 3 0 0 2 1 1
2 2 2 0 4 1 0 1 1 1
2 2 2 0 4 2 0 2 1 1
0 2 2 1 1 0 3 1 1 1
0 2 2 2 1 0 0 2 1 1
0 2 2 1 1 0 4 2 1 1
1 2 1 3 0 0 0 1 1 1
2 2 1 0 0 0 0 2 1 1
1 2 1 4 0 0 0 2 1 1
];

a = addrule(a,ruleList);
% showrule(a,[1 2 3 4 5 6 7 8  9 10 11 12],'symbolic')
  
writefis(a,'D:\University\Tez\implementation\myfile');
fismat = readfis('D:\University\Tez\implementation\myfile');

% sug_fismat = mam2sug(fismat);



% final2=[g2,g4,g7,g9,g10,g11,g12,g13]';
final_test=final(find(test),:);
final1_test=final_test';


out1=evalfis(final1_test,fismat);
class_test=class12(find(test),:);
 k1=0;
 for i=1:length(out1)
     
     if out1(i)<=0
         j1=0;
     else
         j1=1;
     end
   %l=j1;
   if (j1~=class_test(i))
       k1=k1+1;
   end
  
   
 end

error(d,1)=(k1/length(final_test));
end
end
end

