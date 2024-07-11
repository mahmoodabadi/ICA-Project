function z=BenchmarkFunction1(x)
% if nargin<2
%     error('Name or Number of function is not specified.');
% end

% switch number
%     
%     case 1 % Function 1
%         z=sum(x'.^2)';
%         
%     case 2 % Function 2
%         z=zeros(size(x,1),1);
%         for i=1:size(x,2);
%             z=z+i*x(:,i).^4;
%         end
%         
%     case 3 % Function 3
        z=0.5+(sin(sqrt(x(:,1).^2+x(:,2).^2))-0.5)./(1+0.001*(x(:,1).^2+x(:,2).^2)).^2;
%         
%     case 4 % Function 4
%         z=zeros(size(x,1),1);
%         p=ones(size(x,1),1);
%         for i=1:size(x,2)
%             z=z+1/4000*(x(:,i)-100).^2;
%             p=p.*(cos((x(:,i)-100)/sqrt(i))+1);
%         end
%         
%     case 5 % Function 5
%         z=zeros(size(x,1),1);
%         for i=1:size(x,2)-1;
%             z=z+100*(x(:,i+1)-x(:,i).^2).^2+(x(:,i)-1).^2;
%         end
%         
%     case 6 % Function 6
%         z=sum(x'.^2-10*cos(2*pi*x')+10)';
%     case 7 % Designing a PID controller for a SISO system
%         s = tf('s');
%         %     G = tf([1 2],[1 5 5 5]);
%         G = 4.228/(s+0.5)/(s^2+1.64*s+8.456);
%         for jj = 1:size(x,1)
%             
%             KP = x(jj,1);
%             KI = x(jj,2);
%             KD = x(jj,3);
%             PID_Controller = KP + KD*s + KI/s;
%             % G = (1 - 5*s)  /  (  (1+10*s)*(1+20*s)  )
%             %
%             % Arash System
%             SERIES = series(G,PID_Controller);
%             ClosedLoop = feedback(SERIES,1);
%             gam = 0.01;
%             t_in = [0:gam:40];
%             [y,t] = step(ClosedLoop,t_in);
%             %         step(ClosedLoop,t_in);
%             % hold on
%             % step(G);
%             % [y,t] = step(G,t_in);
%             
%             %=====================================================
%             %  Finding Max Overshoot
%             %=====================================================
%             maxovershoot = 0;
%             if max(y)>1
%                 ind = find(y==max(y));
%                 maxovershoot = (y(ind) - 1);
%                 %     hold on
%                 %     plot(t(ind),y(ind),'rp')
%                 %     hold off
%             end
%             
%             %=====================================================
%             %  Finding Rise Time
%             %=====================================================
%             y_1_10 = abs(y - 0.1);
%             y_9_10 = abs(y - 0.9);
%             
%             index1_10 = find(   y_1_10 < (5*min(y_1_10))  );
%             index1_10 = index1_10(1);
%             
%             index9_10 = find(   y_9_10 < (5*min(y_9_10))  );
%             index9_10 = index9_10(1);
%             
%             RiseTime = t(index9_10)-t(index1_10);y_1_10 = abs(y - 0.1);
%             % hold on
%             % plot(t(index9_10),y(index9_10),'gp' , t(index1_10),y(index1_10),'gp')
%             % hold off
%             
%             %=====================================================
%             %  Finding Settling Time
%             %=====================================================
%             y_1_2_100 = abs(y - 1.05);
%             y_0_98_100 = abs(y - 0.95);
%             y_1 = abs(y - 1);
%             
%             index1_2_100 = find(   y_1_2_100 < (0.01 + min(y_1_2_100))  );
%             index0_98_100 = find(   y_0_98_100 < (0.01 + min(y_0_98_100))  );
%             % hold on
%             % plot(t(index1_2_100),y(index1_2_100),'k.'  ,  t(index0_98_100),y(index0_98_100),'y.')
%             % hold off
%             settling_time = t(end);
%             settling_time_index = numel(t);
%             all_indexes = sort([index1_2_100 ;  index0_98_100]);
%             
%             for ii = 1:numel(all_indexes)
%                 if (          sum( (y_1(all_indexes(ii):end)>0.05) )  ) == 0
%                     settling_time_index = all_indexes(ii);
%                     settling_time = t(all_indexes(ii));
%                     break
%                 end
%             end
%             %         hold on
%             %         plot(settling_time,y(settling_time_index),'kp')
%             %         hold off
%             
%             %=====================================================
%             %  Finding IAE
%             %=====================================================
%             IAE = sum(abs(y-1))*gam;
%             %=====================================================
%             %  Returning
%             %=====================================================
%             z(jj,1) = 1*(maxovershoot  +  RiseTime +  IAE  +  settling_time);
%         end
%         
%     otherwise
%         error('Invalid function number is used.');
% end

end