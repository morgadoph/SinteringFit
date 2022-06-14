function [parametro, chi2] = Expterm1 (dados)


%Bloco que faz ajustes de expansão térmica não levando em consideração covariância 
chi2=zeros(7);
parametro=zeros(7,2);
[parametro1,chi2(1)]=MMQpolinomialgrau(dados,1);    
[parametro2,chi2(2)]=MMQpolinomialgrau(dados,2);   
[parametro3,chi2(3)]=MMQpolinomialgrau(dados,3);    
[parametro4,chi2(4)]=MMQpolinomialgrau(dados,4);    
[parametro5,chi2(5)]=MMQpolinomialgrau(dados,5);    
[parametro6,chi2(6)]=MMQpolinomialgrau(dados,6);    
[parametro7,chi2(7)]=MMQpolinomialgrau(dados,7);    

parametro =[parametro1;
            parametro2;
            parametro3;
            parametro4;
            parametro5;
            parametro6;
            parametro7]


end


