function  [Codebooks] = LBG(Cepstrum,M)
 % input(mel_spec):  cepstrum
 % input(M): centroid numbers
 % output(Codebooks): group of centroids
 
 [Nb,Nf] = size(Cepstrum);

 epson = 0.000001;                  % splitting parameter
 Threshold = 1e-6;              %Converge threshold
 % initialize the centroid
 C1 = mean(Cepstrum,2);
 C_array = [C1];
 m = 1;
 
 % keep split centroid until m > M
 while( (2*m) <= M)
     [D1,D2] =size(C_array);
     B_array = zeros(D1,D2*2);
     for i = 1:D2
         y1 = C_array(:,i)*(1+ epson);
         y2 = C_array(:,i)*(1- epson);
         B_array(:,(2*i-1):(2*i)) = [y1,y2];
     end

     
     Group_num = 2*D2;
     Group_ref = zeros(1,Nf);
     Logic = 1;
     while(Logic)
         for i = 1:Nf
             com = inf;
             count = 0;
             for j = 1:Group_num
                 if norm(B_array(:,j)-Cepstrum(:,i))<com 
                     com = norm(B_array(:,j)-Cepstrum(:,i));
                     count = j;
                 end
             end
             Group_ref(i) = count;
         end
         
         % regroup and find new centroids
         B_array_new = zeros(D1,Group_num);
         for i = 1:Group_num
             array = [];
             for j = 1:Nf
                 if Group_ref(j) == i
                     array = [array,Cepstrum(:,j)];
                 end
             end
             if isempty(array)~= 1
                B_array_new(:,i) = mean(array,2);
             end
         end
         
         Logic = sum(((B_array - B_array_new) > Threshold)*ones(Group_num,1));
         B_array = B_array_new;
     end
     C_array = B_array;
     m = m*2;
 end
Codebooks  = C_array;     

end