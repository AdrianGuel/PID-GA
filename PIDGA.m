clear all
close all
timerVal=tic;
a=-1;
b=1;
totalpop=1000;
mutationRate = .1;     
population=DNA.empty(0,totalpop);
auxf=zeros(1,totalpop);

parfor (i=1:totalpop,3)
    population(i)=DNA(2,0,a,b);
end

%calculate fitness
parfor (i=1:totalpop,3)
   population(i).fitness=exp(-response(population(i).genes));
   auxf(i)=population(i).fitness;
end

dist=abs(auxf-1);
minDist=min(dist);
idx=find(dist==minDist);

%z=1;
while minDist>0.4
child=DNA.empty();
newpopulation=DNA.empty(0,totalpop);
parfor (i=1:totalpop,3)
    partnerA=acceptReject(population);
    partnerB=acceptReject(population);
    child=crossover(partnerA,partnerB);
    child=mutate(child,mutationRate,a,b);
    newpopulation(i)=child;
end
population=newpopulation;

%calculate fitness
parfor (i=1:totalpop,3)
   population(i).fitness=exp(-response(population(i).genes));
   auxf(i)=population(i).fitness;
end


dist=abs(auxf-1);
minDist=min(dist);
idx=find(dist==minDist);

%z=z+1;
clear child
end


Elapsetime=toc(timerVal);
[RMSE,t,y,unitstep]=response(population(idx).genes);

figure
plot(t,unitstep,t,y)
xlabel('t (s)','Interpreter','Latex','FontSize', 12)
ylabel('$y(t)$','Interpreter','Latex','FontSize', 12)
set(gcf,'color','w');


