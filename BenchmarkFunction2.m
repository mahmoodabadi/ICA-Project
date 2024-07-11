function error=BenchmarkFunction2(in)
% number=2;
% if nargin<2
%     error('Name or Number of function is not specified.');
% end
% size(x,1)
warning('off')
 
 for d=1:size(in,1);

    k=in(d,1:26); 
    w=in(d,27:52);


mf_array=[-1 0 1;1 2 3;2 3 4;94 120 146;120 146 172;172 185 200;1 2 3;2 3 4;3 4 5;2 4 5;5 6 7;6 7 8;-1 0 1;0 1 2;1 2 3;2 3 4;124 200 245;245 270 295;270 295 320;320 480 565;-1 0 0.9;0 0.9 1.35;1.35 5 7;70 110 152;110 152 192;180 192 202];
%new_mfarray=[-1 0 1;1 2 3;2 3 4;94 120 146;120 146 172;172 185 200;1 2 3;2 3 4;3 4 5;2 4 5;5 6 7;6 7 8;-1 0 1;0 1 2;1 2 3;2 3 4;124 200 245;245 270 295;270 295 320;320 480 565;-1 0 0.9;0 0.9 1.35;1.35 5 7;70 110 152;110 152 192;180 192 202];
mf_max=1/30*[1,3,4,146,172,200,3,4,5,5,7,8,1,2,3,4,245,295,320,565,0.9,1.35,7,152,192,202];

for i=1:26
    shift_k(i,1)=mf_max(i)*k(i)-mf_max(i)*w(i);
    shift_k(i,2)=mf_max(i)*k(i);
    shift_k(i,3)=k(i)+w(i);
end

new_mfarray=mf_array+shift_k;

load 'D:\University\TEZ implementation\mat files\clevhung.mat';
g2=trestbps(1:468);
g4=cp(1:468);
g7=thal(1:468);
g9=ca(1:468);
g10=chol(1:468);
g11=oldpeak(1:468);
g12=thalach(1:468);
t = classregtree([g2,g4,g7,g9,g10,g11,g12],class1);
t2=prune(t,'level',7);
% view(t2)
n=[g2,g4,g7,g9,g10,g11,g12];
x=eval(t2,n);
k1=0;
v=cellstr(class1);
for i=1:length(x)
    if x{i}==v{i}
        k1=k1+1;
    end
end
error_tree=1-(k1/(length(x)));






a = newfis('heart');




%...................................................input2=trestbps
a = addvar(a,'input','trestbps',[94 200]);

a = addmf(a,'input',1,'low','trimf',new_mfarray(4,:));
a = addmf(a,'input',1,'medium','trimf',new_mfarray(5,:));
a = addmf(a,'input',1,'high','trimf',new_mfarray(6,:));

%...................................................input3=cp

a = addvar(a,'input','cp',[1 5]);

a = addmf(a,'input',3,'low','trimf',new_mfarray(7,:));
a = addmf(a,'input',3,'low','trimf',new_mfarray(8,:));
a = addmf(a,'input',3,'medium','trimf',new_mfarray(9,:));

%....................................................input4=thal
a = addvar(a,'input','thal',[2 8]);

a = addmf(a,'input',4,'low','trimf',new_mfarray(10,:));
a = addmf(a,'input',4,'medium','trimf',new_mfarray(11,:));
a = addmf(a,'input',4,'high','trimf',new_mfarray(12,:));


%..................................................input5=ca
a = addvar(a,'input','ca',[0 4]);

a = addmf(a,'input',5,'low','trimf',new_mfarray(13,:));
a = addmf(a,'input',5,'medium','trimf',new_mfarray(14,:));
a = addmf(a,'input',5,'high','trimf',new_mfarray(15,:));
a = addmf(a,'input',5,'very high','trimf',new_mfarray(16,:));

%...................................................input6=chol
a = addvar(a,'input','chol',[124 565]);

a = addmf(a,'input',6,'low','trimf',new_mfarray(17,:));
a = addmf(a,'input',6,'medium','trimf',new_mfarray(18,:));
a = addmf(a,'input',6,'high','trimf',new_mfarray(19,:));
a = addmf(a,'input',6,'very high','trimf',new_mfarray(20,:));

%....................................................input7=oldpeak
a = addvar(a,'input','oldpeak',[0 8]);

a = addmf(a,'input',7,'low','trimf',new_mfarray(21,:));
a = addmf(a,'input',7,'medium','trimf',new_mfarray(22,:));
a = addmf(a,'input',7,'high','trimf',new_mfarray(23,:));
%....................................................input8=thalach
a = addvar(a,'input','thalach',[70 202]);

a = addmf(a,'input',8,'low','trimf',new_mfarray(24,:));
a = addmf(a,'input',8,'medium','trimf',new_mfarray(25,:));
a = addmf(a,'input',8,'high','trimf',new_mfarray(26,:));

%................................................output
 
a = addvar(a,'output','determination',[-1 1]);
a = addmf(a,'output',1,'A','trapmf',[-20 -3 -0.5 0.5]);
a = addmf(a,'output',1,'B','trapmf',[0.5 1 4 20]);
% a = addmf(a,'output',1,'C','trimf',[1.5 2 2.5]);
% a = addmf(a,'output',1,'D','trimf',[2.5 3 3.5]);
% a = addmf(a,'output',1,'E','trimf',[3.5 4 4.5]);

%.................................................



ruleList=[
0 0 2 0 0 0 0 0 1 1 1
0 0 3 2 1 0 0 0 1 1 1
0 0 3 3 1 2 0 0 2 1 1
0 0 3 3 1 2 1 0 1 1 1
0 0 3 3 1 2 2 0 2 1 1
0 1 3 0 2 0 0 1 2 1 1
0 1 3 2 3 0 0 2 2 1 1
0 1 3 3 3 0 0 2 2 1 1
0 1 3 0 3 0 0 2 2 1 1
0 1 3 0 4 0 0 2 2 1 1
2 2 3 0 2 0 0 0 2 1 1
3 2 3 0 2 0 0 0 2 1 1
];

a = addrule(a,ruleList);
% showrule(a,[1 2 3 4 5 6 7 8  9 10 11 12],'symbolic')
  
writefis(a,'D:\University\Tez\implementation\myfile');
fismat = readfis('D:\University\Tez\implementation\myfile');


sug_fismat = mam2sug(fismat);

g2=trestbps(469:587);
g4=cp(469:587);
g7=thal(469:587);
g9=ca(469:587);
g10=chol(469:587);
g11=oldpeak(469:587);
g12=thalach(469:587);


final2=[g2,g4,g7,g9,g10,g11,g12]';

 
out1=evalfis(final2,sug_fismat)

 k1=0;
 for i=1:length(out1)
     
     if out1(i)<=0
         j1=0;
     else
         j1=1;
     end
%      j1=round(out1(i));
     
%    if (j1<0)
%        j1=0;
%    elseif (j1>4)
%        j1=4;
%    
%    end
   l=j1;
   if (l~=class5(i))
       k1=k1+1;
   end
  
   
end
error(d,1)=(k1/618);
end
end


