function [Vfinal]=V_suave(dados, Vdados, vizinhos)

ndados=size(dados);
C=zeros(ndados(1),ndados(1));

for i=1:ndados(1)
        if i< (vizinhos+1)
            C(i,1)=(vizinhos-i+1)/(2*vizinhos+1);
            naux=i+vizinhos;
            for j=2:naux
                C(i,j)=1/(2*vizinhos+1);
            end
        elseif i> (ndados(1)-vizinhos)
            C(i,ndados(1))=(vizinhos+ndados(1)-i+1)/(2*vizinhos+1);
            naux=i-vizinhos;
            naux2=ndados(1)-1;
            for j=naux:naux2
                C(i,j)=1/(2*vizinhos+1);
            end
        else
            naux=i-vizinhos;
            naux2=i+vizinhos;
            for j=naux:naux2
                C(i,j)=1/(2*vizinhos+1);
            end
        end
                      
        
end

Vfinal = C*Vdados*C';

end

