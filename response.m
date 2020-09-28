function varargout=response(gains)
s = tf('s');
P = (s-2)*exp(-2*s)/(s^2+0.5*s+3.25);
C = gains(1)+gains(2)/s;
T = feedback(P*C,1);
[y,t]=step(T,50);
unitstep = t>=2;
RMSE = sqrt(mean((unitstep - y).^2)); 
    if abs(nargout)==1
        varargout={RMSE};
    else
        varargout={RMSE,t,y,unitstep};
    end
end