function  [T_Disturbance] = VQ_dis(Codebooks,Cepstrum)
 % input(Cepstrum):  Cepstrum
 % input(Codebooks): Codebooks
 % output(Disturbance): Total VQ disturbance
 [~,D2] = size(Codebooks);
 [~,Nf] = size(Cepstrum);
 Disturbance = zeros(Nf,D2);
 for i = 1:Nf
    for j = 1:D2
        Disturbance(i,j) = norm(Codebooks(:,j)-Cepstrum(:,i));
    end
 end
 T_Disturbance = sum(min(Disturbance,[],1));
end