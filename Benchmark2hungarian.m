 function error=Benchmark2hungarian(in)
% number=2;
% if nargin<2
%     error('Name or Number of function is not specified.');
% end
% size(x,1)
warning('off')

 for d=1:size(in,1);

    k=in(d,1:18); 
    w=in(d,19:36);


mf_array=[-1 0 1;0 1 2;0 1 2;1 2 3;2 3 4;100 120 134;120 134 160;134 160 200;1 2 3;2 3 4;3 4 5;70 85 101;101 120 129;120 129 135;129 135 200;-1 0 1;0 1 2;1 2 3];
%new_mfarray=[-1 0 1;1 2 3;2 3 4;94 120 146;120 146 172;172 185 200;1 2 3;2 3 4;3 4 5;2 4 5;5 6 7;6 7 8;-1 0 1;0 1 2;1 2 3;2 3 4;124 200 245;245 270 295;270 295 320;320 480 565;-1 0 0.9;0 0.9 1.35;1.35 5 7;70 110 152;110 152 192;180 192 202];
mf_max=1/30*[1,2,2,3,4,134,160,200,3,4,5,101,129,135,200,1,2,3];

for i=1:18
    shift_k(i,1)=mf_max(i)*k(i)-mf_max(i)*w(i);
    shift_k(i,2)=mf_max(i)*k(i);
    shift_k(i,3)=k(i)+w(i);
end

new_mfarray=mf_array+shift_k;

load 'D:\University\TEZ implementation\mat files\hungarian.mat';

% t = classregtree([g2,g4,g7,g9,g10,g11,g12,g13],class1);
t=classregtree([g2,g3,g4,g7,g8,g11],class1);
t2=prune(t,'level',3);
 %view(t2)
n=[g2,g3,g4,g7,g8,g11];
%n=[g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13];
x=eval(t2,n);
k1=0;

 v=cellstr(class1);
%  mean(strcmp(x,class1))
for i=1:length(x)
    if x{i}==v{i}
        k1=k1+1;
    end
end
error_tree=1-(k1/(length(x)));







a = newfis('heart1hungarian');





...................................................input1=sex

a = addvar(a,'input','sex',[-1 2]);

a = addmf(a,'input',1,'s2','trimf',new_mfarray(1,:));
a = addmf(a,'input',1,'l2','trimf',new_mfarray(2,:));


...................................................input2=slope

a = addvar(a,'input','slope',[0 4]);

a = addmf(a,'input',2,'s3','trimf',new_mfarray(3,:));
a = addmf(a,'input',2,'m3','trimf',new_mfarray(4,:));
a = addmf(a,'input',2,'l3','trimf',new_mfarray(5,:));

%...................................................input3=trestbps
a = addvar(a,'input','trestbps',[100 200]);

a = addmf(a,'input',3,'low','trimf',new_mfarray(6,:));
a = addmf(a,'input',3,'medium','trimf',new_mfarray(7,:));
a = addmf(a,'input',3,'high','trimf',new_mfarray(8,:));

%...................................................input4=cp

a = addvar(a,'input','cp',[1 5]);

a = addmf(a,'input',4,'low','trimf',new_mfarray(9,:));
a = addmf(a,'input',4,'low','trimf',new_mfarray(10,:));
a = addmf(a,'input',4,'medium','trimf',new_mfarray(11,:));

%....................................................input5=thalach
a = addvar(a,'input','thalach',[70 202]);

a = addmf(a,'input',5,'low','trimf',new_mfarray(12,:));
a = addmf(a,'input',5,'medium','trimf',new_mfarray(13,:));
a = addmf(a,'input',5,'high','trimf',new_mfarray(14,:));
a = addmf(a,'input',5,'very high','trimf',new_mfarray(15,:));

%....................................................input6=resteg

a = addvar(a,'input','slope',[0 3]);

a = addmf(a,'input',6,'s3','trimf',new_mfarray(16,:));
a = addmf(a,'input',6,'m3','trimf',new_mfarray(17,:));
a = addmf(a,'input',6,'l3','trimf',new_mfarray(18,:));


%................................................output
 
a = addvar(a,'output','determination',[-1 5]);
a = addmf(a,'output',1,'A','trimf',[-1 0 0.5]);
a = addmf(a,'output',1,'B','trimf',[0.5 1 1.5]);
a = addmf(a,'output',1,'C','trimf',[1.5 2 2.5]);
a = addmf(a,'output',1,'D','trimf',[2.5 3 3.5]);
a = addmf(a,'output',1,'E','trimf',[3.5 4 4.5]);

%.................................................


ruleList=[
0 1 0 0 0 0 1 1 1
1 2 0 0 0 0 1 1 1
2 2 1 2 0 0 1 1 1
2 2 1 3 0 0 2 1 1
2 2 2 2 0 0 4 1 1
2 2 2 3 4 0 5 1 1
2 2 2 3 3 2 4 1 1
2 2 2 3 4 1 2 1 1
2 2 2 3 3 1 3 1 1
2 2 2 3 1 1 3 1 1
2 2 2 3 2 1 4 1 1
];

a = addrule(a,ruleList);
% showrule(a,[1 2 3 4 5 6 7 8  9 10 11 12],'symbolic')
  
writefis(a,'D:\University\Tez\implementation\myfilehungarian');
fismat = readfis('D:\University\Tez\implementation\myfilehungarian');

sug_fismat = mam2sug(fismat);


final2=[g2,g3,g4,g7,g8,g11]';

out1=evalfis(final2,sug_fismat);

 k1=0;
 for i=1:length(out1)
     j1=round(out1(i));
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
error(d,1)=(k1/294);
end
end


