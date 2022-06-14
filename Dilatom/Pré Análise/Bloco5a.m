function [parametro, chi2] = Expterm1 (dados)


%Bloco que faz ajustes de expansão térmica não levando em consideração covariância 
chi2=zeros(7);
parametro=zeros(7,2);
[parametro1,chi2(1)]=MMQpolinomialgrau(curva1res,1);    
[parametro2,chi2(2)]=MMQpolinomialgrau(curva1res,2);   
[parametro3,chi2(3)]=MMQpolinomialgrau(curva1res,3);    
[parametro4,chi2(4)]=MMQpolinomialgrau(curva1res,4);    
[parametro5,chi2(5)]=MMQpolinomialgrau(curva1res,5);    
[parametro6,chi2(6)]=MMQpolinomialgrau(curva1res,6);    
[parametro7,chi2(7)]=MMQpolinomialgrau(curva1res,7);    

parametro =[parametro1;
            parametro2;
            parametro3;
            parametro4;
            parametro5;
            parametro6;
            parametro7]


end


