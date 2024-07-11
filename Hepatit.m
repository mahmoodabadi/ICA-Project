function error=Hepatit(in)
% number=2;
% if nargin<2
%     error('Name or Number of function is not specified.');
% end
% size(x,1)
warning('off')
load 'D:\University\TEZ implementation\mat files\Hepatit.mat';


t = classregtree(final,class1);
t2=prune(t,'level',0);
 view(t2)
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
s=0;
for i=1:10

    test = (indices == i); train = ~test;

final_test=final(find(test),:);
final_train=final(find(train),:);


 for d=1:size(in,1)

    k=in(d,1:39); 
    w=in(d,40:78);


mf_array=[0 0.111 0.511;0.111 0.511 0.911;0.511 0.911 1.111;0 0.2 0.4;0.2 0.4 0.6;0.4 0.6 0.8;0.6 0.8 1;0 0.2 0.4;0.2 0.4 0.6;0.4 0.6 0.8;0.6 0.8 1;0 0.2 0.4;0.2 0.4 0.6;0.4 0.6 0.8;0.6 0.8 1;0 0.2 0.4;0.2 0.4 0.6;0.4 0.6 0.8;0.6 0.8 1;-0.125 0.075 0.275;0.075 0.275 0.475;0.275 0.475 0.675;0.475 0.675 1;-0.111 0.089 0.289;0.089 0.289 0.489;0.289 0.489 0.941;0.489 0.941 1.593;-0.175 0.025 0.225;0.025 0.225 0.425;0.225 0.425 0.725;0.425 0.725 1;0.06 0.160 0.360;0.160 0.360 0.520;0.360 0.520 0.680;0.520 0.680 1;0 0.2 0.4;0.2 0.4 0.6;0.4 0.6 0.8;0.6 0.8 1];
%new_mfarray=[-1 0 1;1 2 3;2 3 4;94 120 146;120 146 172;172 185 200;1 2 3;2 3 4;3 4 5;2 4 5;5 6 7;6 7 8;-1 0 1;0 1 2;1 2 3;2 3 4;124 200 245;245 270 295;270 295 320;320 480 565;-1 0 0.9;0 0.9 1.35;1.35 5 7;70 110 152;110 152 192;180 192 202];
mf_max=1/30*[0.511,0.911,1.111,0.4,0.6,0.8,1,0.4,0.6,0.8,1,0.4,0.6,0.8,1,0.4,0.6,0.8,1,0.275,0.475,0.675,1,0.289,0.489,0.941,1.593,0.225,0.425,0.725,1,0.360,0.520,0.680,1,0.4,0.6,0.8,1];

for j=1:39
    shift_k(j,1)=mf_max(j)*k(j)-mf_max(j)*w(j);
    shift_k(j,2)=mf_max(j)*k(j);
    shift_k(j,3)=k(j)+w(j);
end

new_mfarray=mf_array+shift_k;



class_train=class1(find(train),:);

% 
% t = classregtree(final_train,class_train);
% %t2=prune(t,'level',0);
% view(t)
% n=final_train;%[g,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13];
% x=eval(t,n);
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
a = addvar(a,'input','clump',[0 1.111]);

a = addmf(a,'input',1,'low','trimf',new_mfarray(1,:));
a = addmf(a,'input',1,'medium','trimf',new_mfarray(2,:));
a = addmf(a,'input',1,'high','trimf',new_mfarray(3,:));


%...................................................input2=Uni1

a = addvar(a,'input','Uni1',[0 1]);

a = addmf(a,'input',2,'low','trimf',new_mfarray(4,:));
a = addmf(a,'input',2,'medium','trimf',new_mfarray(5,:));
a = addmf(a,'input',2,'high','trimf',new_mfarray(6,:));
a = addmf(a,'input',2,'high1','trimf',new_mfarray(7,:));

%....................................................input3=Uni2
a = addvar(a,'input','Uni2',[0 1]);

a = addmf(a,'input',3,'low','trimf',new_mfarray(8,:));
a = addmf(a,'input',3,'medium','trimf',new_mfarray(9,:));
a = addmf(a,'input',3,'high','trimf',new_mfarray(10,:));
a = addmf(a,'input',3,'high','trimf',new_mfarray(11,:));


%..................................................input4=Marginal
a = addvar(a,'input','Marginal',[0 1]);

a = addmf(a,'input',4,'low','trimf',new_mfarray(12,:));
a = addmf(a,'input',4,'medium','trimf',new_mfarray(13,:));
a = addmf(a,'input',4,'high','trimf',new_mfarray(14,:));
a = addmf(a,'input',4,'high1','trimf',new_mfarray(15,:));


%...................................................input5=Single
a = addvar(a,'input','Single',[0 1]);

a = addmf(a,'input',5,'low','trimf',new_mfarray(16,:));
a = addmf(a,'input',5,'medium','trimf',new_mfarray(17,:));
a = addmf(a,'input',5,'high','trimf',new_mfarray(18,:));
a = addmf(a,'input',5,'high1','trimf',new_mfarray(19,:));


%....................................................input6=Bare
a = addvar(a,'input','Bare',[-0.125 1]);

a = addmf(a,'input',6,'low','trimf',new_mfarray(20,:));
a = addmf(a,'input',6,'medium','trimf',new_mfarray(21,:));
a = addmf(a,'input',6,'high','trimf',new_mfarray(22,:));
a = addmf(a,'input',6,'high1','trimf',new_mfarray(23,:));
%....................................................input7=Bland
a = addvar(a,'input','Bland',[-0.111 1.593]);

a = addmf(a,'input',7,'low','trimf',new_mfarray(24,:));
a = addmf(a,'input',7,'medium','trimf',new_mfarray(25,:));
a = addmf(a,'input',7,'high','trimf',new_mfarray(26,:));
a = addmf(a,'input',7,'high1','trimf',new_mfarray(27,:));

%....................................................input8=Normal
a = addvar(a,'input','Normal',[-0.175 1]);

a = addmf(a,'input',8,'low','trimf',new_mfarray(28,:));
a = addmf(a,'input',8,'medium','trimf',new_mfarray(29,:));
a = addmf(a,'input',8,'high','trimf',new_mfarray(30,:));
a = addmf(a,'input',8,'high1','trimf',new_mfarray(31,:));

%....................................................input9=Normal
a = addvar(a,'input','Normal11',[0 1]);

a = addmf(a,'input',9,'low','trimf',new_mfarray(32,:));
a = addmf(a,'input',9,'medium','trimf',new_mfarray(33,:));
a = addmf(a,'input',9,'high','trimf',new_mfarray(34,:));
a = addmf(a,'input',9,'high1','trimf',new_mfarray(35,:));

%....................................................input10=Normal
a = addvar(a,'input','Normal22',[0 1]);

a = addmf(a,'input',10,'low','trimf',new_mfarray(36,:));
a = addmf(a,'input',10,'medium','trimf',new_mfarray(37,:));
a = addmf(a,'input',10,'high','trimf',new_mfarray(38,:));
a = addmf(a,'input',10,'high1','trimf',new_mfarray(39,:));


%................................................output
 
a = addvar(a,'output','determination',[-1 1]);
a = addmf(a,'output',1,'A','trapmf',[-20 -3 -0.5 0.5]);
a = addmf(a,'output',1,'B','trapmf',[0.5 1 4 20]);
% a = addmf(a,'output',1,'C','trimf',[1.5 2 2.5]);
% a = addmf(a,'output',1,'D','trimf',[2.5 3 3.5]);
% a = addmf(a,'output',1,'E','trimf',[3.5 4 4.5]);

%.................................................


ruleList=[
0 0 0 0 2 2 1 0 0 0 2 1 1
0 0 0 0 2 2 2 0 0 0 1 1 1
2 2 0 0 3 2 0 0 0 0 2 1 1
3 2 0 0 3 2 0 0 0 0 1 1 1
0 3 0 0 3 2 0 0 0 0 1 1 1
0 0 0 0 0 1 4 0 3 0 1 1 1
0 0 0 3 0 1 3 0 3 0 2 1 1
0 0 2 2 0 1 3 0 3 0 1 1 1
0 0 3 2 0 1 3 1 3 0 1 1 1
0 0 3 2 0 1 1 2 3 0 1 1 1
0 0 3 2 0 1 3 0 3 0 2 1 1
0 0 0 0 0 1 0 0 2 2 2 1 1
0 0 0 0 0 1 0 0 1 3 2 1 1
0 0 0 0 0 1 0 0 2 3 1 1 1
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
 k1=0;tp=0;fp=0;fn=0;tn=0;
 for m=1:length(out1)
     
     if out1(m)<=0
         j1=0;
     else
         j1=1;
     end
   %l=j1;
   if (j1~=class_test(m))
       k1=k1+1;
   end
if (j1>0) && (class_test(m)>0)
      tp=tp+1;
   
%    elseif (l==1) && (class_test==0)
elseif (j1>0) && (class_test(m)<=0)
           fn=fn+1;
       
%    elseif (l==0) && (class_test==1)
elseif (j1<=0) && (class_test(m)>0)
       fp=fp+1;
%    elseif (l==0) && (class_test==0)
elseif (j1<=0) && (class_test(m)<=0)
       tn=tn+1;
end

 end
 
 CM=[tp fp;fn tn]
length(class_test);
i
error(d,1)=(k1/length(final_test))  


end
end
end


