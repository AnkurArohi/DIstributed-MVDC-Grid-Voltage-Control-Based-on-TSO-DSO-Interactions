function [bin,out]=DataGen(m)  

 % Function to Generate Training Data set for training neural network of a  
 % line follower  
 %    
 %     [bin,out]=DataGen(number of inputs)  
 %       

 % NN Network to be trained  
 n=(2^m)-1;              
 bin=decimalToBinaryVector(0:n);   
 [p,q]=size(bin);             
 out=zeros(p,1);   
 bLeft=bin(:,1:(q/2));  
 bRight=bin(:,((q/2)+1):end);  
 wL=bi2de(bLeft,'left-msb');  
 wR=bi2de(bRight,'right-msb');  
  for i=1:p  
    if wL(i)>wR(i)  
      out(i)=-1;  
    end   
    if wL(i)<wR(i)  
      out(i)=1;  
    end  
    if wL(i)==wR(i)  
      out(i)=0;  
    end    
  end  
 end  