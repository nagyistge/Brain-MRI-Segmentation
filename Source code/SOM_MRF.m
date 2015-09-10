function SOM
clc
clear
t1_raw=imread('t1.gif');   %Importing Raw Image t1
t2_raw=imread('t2.gif');   %Importing Raw Image t2
pd_raw=imread('pd.gif');   %Importing Raw Image pd
wij = -1;
b = 1;
weight = wij + (b-wij).*rand(256,256,6);  %weight updation % 6 times of 256 * 256 matrix for six classification

Final_Matrix = zeros(256,256,6); %final ouput classifier image matrix

for iter = 1:3  %Iterations %as per the research paper 3000 iterations
    for t=1:3   %normalising the input
        if(t==1)
            t1 = t1_raw;
        elseif(t==2)
            t1 = t2_raw;
        elseif(t==3)
            t1 = pd_raw;
        end
    end    
        dis = zeros(1,6);  %distance matrix
        
        for i1=1:256
            for j1=1:256
                val = t1(i1,j1);
                for k=1:6
                    total = 0;
                    for i=1:256
                        for j=1:256
                            tem = double(double(val)- double(weight(i,j,k)));
                            tem = double(double(tem) *double(tem)) ;
                            total = double(double(total) +double(tem)); %distance calculations
                        end
                    end
                    dis(1,k)=total;
                end
                tem = dis(1,1);
                selected = 1;
                for i=2:6
                    if(tem>dis(1,i))
                        tem = dis(1,i);
                        selected = i;
                    end
                    %selected = i
                end
                m=i1;
                n=j1;
                total = 0;
                count = 0;
                total = total + t1(m,n);
                count = count + 1;
                Final_Matrix(m,n,selected) = t1(m,n);
                if(m~=1)
                    total = total + t1(m-1,n);
                    count = count + 1;
                    Final_Matrix(m-1,n,selected) = t1(m-1,n);
                    if(n~=1)
                        total = total + t1(m-1,n-1);
                        count = count + 1;
                        Final_Matrix(m-1,n-1,selected) = t1(m-1,n-1);
                    end
                    if(n~=256)
                        total = total + t1(m-1, n+1);
                        count = count + 1;
                        Final_Matrix(m-1,n+1,selected) = t1(m-1,n+1);
                    end
                end
                if(m~=256)
                    total = total + t1(m+1,n);
                    count = count + 1;
                    Final_Matrix(m+1,n,selected) = t1(m+1,n);
                    if(n~=1)
                        total = total + t1(m+1,n-1);
                        count = count + 1;
                        Final_Matrix(m+1,n-1,selected) = t1(m+1,n-1);
                    end
                    if(n~=256)
                        total = total + t1(m+1, n+1);
                        count = count + 1;
                        Final_Matrix(m+1,n+1,selected) = t1(m+1,n+1);
                    end
                end
                if(n~=1)
                    total = total + t1(m,n-1);
                    count = count + 1;
                    Final_Matrix(m,n-1,selected) = t1(m,n-1);
                end
                if(n~=256)
                    total = total + t1(m, n+1);
                    count = count + 1;
                    Final_Matrix(m,n+1,selected) = t1(m,n+1);
                end
                mean = double(double(total)/double(count));
                e = 0.37;
                tem = 0;
                tem = tem + (-1*e) * double(double(t1(m,n))-double(mean));
                if(m~=1)
                    tem = tem + (-1*e) * double(double(t1(m-1,n))-double(mean));
                    if(n~=1)
                        tem = tem + (-1*e) * double(double(t1(m-1,n-1))-double(mean));
                    end
                    if(n~=256)
                        tem = tem + (-1* e) * double(double(t1(m-1,n+1))-double(mean));
                    end
                end
                if(m~=256)
                    tem = tem + (-1*e) * double(double(t1(m+1,n))-double(mean));
                    if(n~=1)
                        tem = tem + (-1*e) * double(double(t1(m+1,n-1))-double(mean));
                    end
                    if(n~=256)
                        tem = tem + (-1*e) * double(double(t1(m+1,n+1))-double(mean));
                    end
                end
                if(n~=1)
                    tem = tem + (-1*e) * double(double(t1(m,n-1))-double(mean));
                end
                if(n~=256)
                    tem = tem + (-1*e) * double(double(t1(m,n+1))-double(mean));
                end
                u = tem ;
                wij = 0.1;
                weight(m,n,selected) = double(weight(m,n,selected) + double(double(wij * (t1(m,n) - weight(m,n,selected))) + double(u)));
                if(m~=1)
                    weight(m-1,n,selected) =double(weight(m-1,n,selected) + double(double(wij * (t1(m-1,n) - weight(m-1,n,selected))) + double(u)));
                    if(n~=1)
                        weight(m-1,n-1,selected) = double(weight(m-1,n-1,selected) + double(double(wij * (t1(m-1,n-1) - weight(m-1,n-1,selected))) + double(u)));
                    end
                    if(n~=256)
                        weight(m-1,n+1,selected) = double(weight(m-1,n+1,selected) + double(double(wij * (t1(m-1,n+1) - weight(m-1,n+1,selected))) + double(u)));
                    end
                end
                if(m~=256)
                    weight(m+1,n,selected) = double(weight(m+1,n,selected) + double(double(wij * (t1(m+1,n) - weight(m+1,n,selected))) + double(u)));
                    if(n~=1)
                        weight(m+1,n-1,selected) = double(weight(m+1,n-1,selected) + double(double(wij * (t1(m+1,n-1) - weight(m+1,n-1,selected))) + double(u)));
                    end
                    if(n~=256)
                        weight(m+1,n+1,selected) = double(weight(m+1,n+1,selected) + double(double(wij * (t1(m+1,n+1) - weight(m+1,n+1,selected))) + double(u)));
                    end
                end
                if(n~=1)
                    weight(m,n-1,selected) = double(weight(m,n-1,selected) + double(double(wij * (t1(m,n-1) - weight(m,n-1,selected))) + double(u)));
                end
                if(n~=256)
                    weight(m,n+1,selected) = double(weight(m,n+1,selected) + double(double(wij * (t1(m,n+1) - weight(m,n+1,selected))) + double(u)));
                end
            end
        end
    %end
end

%6 Classifiers
classifier1=zeros(256,256); %White Matter
classifier2=zeros(256,256); %Skull
classifier3=zeros(256,256); %scalp
classifier4=zeros(256,256); %CSF
classifier5=zeros(256,256); %Grey Matter
classifier6=zeros(256,256); %Background

for i=1:256
    for j=1:256
        classifier1(i,j)=Final_Matrix(i,j,1);
    end
end
for i=1:256
    for j=1:256
        classifier2(i,j)=Final_Matrix(i,j,2);
    end
end
for i=1:256
    for j=1:256
        classifier3(i,j)=Final_Matrix(i,j,3);
    end
end
for i=1:256
    for j=1:256
        classifier4(i,j)=Final_Matrix(i,j,4);
    end
end
for i=1:256
    for j=1:256
        classifier5(i,j)=Final_Matrix(i,j,5);
    end
end
for i=1:256
    for j=1:256
        classifier6(i,j)=Final_Matrix(i,j,6);
    end
end

imageC(classifier1,classifier2,classifier3,classifier4,classifier5,classifier6)

end