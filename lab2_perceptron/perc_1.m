%        MATLAB code for the Perceptron learning law 
%                Reference : Table 5.5;Page 129 
% 
% ========================================================== 
 
% PERCEPTRON LEARNING ALGORITHM 
% Pattern vectors stored row-wise in matrix p 
p =[1 0 0  
   1 0 1	 
   1 1 0 	 
   1 1 1]; 
 
d =[0 0 0 1];	% Desired outputs stored in vector d 
w =[0 0 0];		% Initial weight vector 
eta = 1;			% Set the learning rate = 1  
update = 1;		% Set the update flag as TRUE 
					% to get into the loop! 
 
while update==1 					% As long as update is TRUE   
   for i=1:4						% For each pattern 
      y = p(i,:)*w'; 			% Calculate the activation 
      if y >= 0 & d(i)== 0 	% Misclassification! 
         w = w - eta*p(i,:);	% Update weights 
         up(i) =1;				% Set the local update FLAG 
      elseif y<=0 & d(i) ==1	% Another misclassification! 
         w = w + eta*p(i,:);	% Update weights 
         up(i) = 1;				% Set the update FLAG 
      else  
         up(i) = 0;				% Reset the update FLAG 
      end 
   end 
   number_of_updates = up * up';% Check number of updates 
   if number_of_updates > 0 
      update =1;				% Repeat epoch 
   else update =0;				% Reset flag, exit 
   end 
end 