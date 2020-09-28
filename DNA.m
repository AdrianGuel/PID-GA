classdef DNA
    properties 
        genes {mustBeNumeric}
        fitness {mustBeNumeric}
    end
    methods
        function obj=DNA(val,fit,a,b)
            if nargin==4
                obj.genes=a+(b-a).*rand(val,1);
                obj.fitness=fit;
            end
        end
        function child=crossover(PartnerA,PartnerB)
            alpha=0.01;
            beta=0.015;
            child=DNA(length(PartnerA.genes),0.0,1,1);
            for i=1:length(PartnerA.genes)
                if PartnerA.fitness>PartnerB.fitness
                    if PartnerA.genes(i)>PartnerB.genes(i)
                        a=PartnerB.genes(i)-alpha*(abs(PartnerA.genes(i)-PartnerB.genes(i)));
                        b=PartnerA.genes(i)+beta*(abs(PartnerA.genes(i)-PartnerB.genes(i)));
                        child.genes(i)=a+(b-a)*rand;
                    else
                        a=PartnerA.genes(i)-beta*(abs(PartnerA.genes(i)-PartnerB.genes(i)));
                        b=PartnerB.genes(i)+alpha*(abs(PartnerA.genes(i)-PartnerB.genes(i)));
                        child.genes(i)=a+(b-a)*rand;                       
                    end
                else
                    if PartnerA.genes(i)>PartnerB.genes(i)
                        a=PartnerB.genes(i)-beta*(abs(PartnerA.genes(i)-PartnerB.genes(i)));
                        b=PartnerA.genes(i)+alpha*(abs(PartnerA.genes(i)-PartnerB.genes(i)));
                        child.genes(i)=a+(b-a)*rand;
                    else
                        a=PartnerA.genes(i)-alpha*(abs(PartnerA.genes(i)-PartnerB.genes(i)));
                        b=PartnerB.genes(i)+beta*(abs(PartnerA.genes(i)-PartnerB.genes(i)));
                        child.genes(i)=a+(b-a)*rand;                       
                    end
                end
            end
        end
        function obj1=mutate(obj2,mutationRate,a,b)
            for i=1:length(obj2.genes)
                if rand<mutationRate
                    obj2.genes(i)=a+(b-a)*rand;
                end
            end
            obj1=obj2;
        end
        function obj=acceptReject(population)
            index=1;
            r=rand;
            while r>0
                r=r-population(index).fitness;
                index=index+1;
            end
            index=index-1;
            obj=population(index);
        end
    end
end

%N random numbers in the interval (a,b) with the formula r = a + (b-a).*rand(N,1).