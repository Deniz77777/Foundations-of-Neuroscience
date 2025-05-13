clear
close all
clc

load('E1_1.mat')
load('E1_2.mat')
load('E2_1.mat')
load('E2_2.mat')
load('E3_1.mat')
load('E3_2.mat')
load('E4_1.mat')
load('E4_2.mat')
load('E5_1.mat')
load('E5_2.mat')
load('E6_1.mat')
load('E6_2.mat')


%% Removing first 15 Events
e1_1=E1_1(:,:,16:47);
e1_2=E1_2(:,:,16:47);
e2_1=E2_1(:,:,16:36);
e2_2=E2_2(:,:,16:36);
e3_1=E3_1(:,:,16:32);
e3_2=E3_2(:,:,16:33);
e4_1=E4_1(:,:,16:39);
e4_2=E4_2(:,:,16:39);
e5_1=E5_1(:,:,16:37);
e5_2=E5_2(:,:,16:37);
e6_1=E6_1(:,:,16:39);
e6_2=E6_2(:,:,16:40);

%%
K1=cat(3,e1_1,e2_1,e3_1);
K2=cat(3,e1_2,e2_2,e3_2);
S1=cat(3,e4_1,e5_1,e6_1);
S2=cat(3,e4_2,e5_2,e6_2);

clearvars -except K1 K2 S1 S2
%% Feature Extraction

for ii=1:30
    for jj=1:70
        temp=K1(ii,:,jj);
        k1(ii,jj,1)= mean(temp);
        k1(ii,jj,2)= var(temp);
        k1(ii,jj,3)= skewness(temp);
        k1(ii,jj,4)= kurtosis(temp);
        k1(ii,jj,5)= wentropy(temp,'shannon');
        k1(ii,jj,6)= wentropy(temp,'log energy');
        k1(ii,jj,7)= mean(temp.^2);
        
        Ftemp=abs(fft(temp));
        k1(ii,jj,8)= mean(Ftemp);
        k1(ii,jj,9)= var(Ftemp);
        k1(ii,jj,10)= skewness(Ftemp);
        k1(ii,jj,11)= kurtosis(Ftemp);
%         k1(ii,jj,12)= wentropy(Ftemp,'shannon');
        k1(ii,jj,12)= wentropy(Ftemp,'log energy');
        k1(ii,jj,13)= mean(Ftemp.^2);
        
    end
end
clear temp Ftemp
%%
for ii=1:30
    for jj=1:71
        temp=K2(ii,:,jj);
        k2(ii,jj,1)= mean(temp);
        k2(ii,jj,2)= var(temp);
        k2(ii,jj,3)= skewness(temp);
        k2(ii,jj,4)= kurtosis(temp);
        k2(ii,jj,5)= wentropy(temp,'shannon');
        k2(ii,jj,6)= wentropy(temp,'log energy');
        k2(ii,jj,7)= mean(temp.^2);
        
        Ftemp=abs(fft(temp));
        k2(ii,jj,8)= mean(Ftemp);
        k2(ii,jj,9)= var(Ftemp);
        k2(ii,jj,10)= skewness(Ftemp);
        k2(ii,jj,11)= kurtosis(Ftemp);
%         k2(ii,jj,12)= wentropy(Ftemp,'shannon');
        k2(ii,jj,12)= wentropy(Ftemp,'log energy');
        k2(ii,jj,13)= mean(Ftemp.^2);
    end
end
clear temp Ftemp
%%
for ii=1:30
    for jj=1:70
        temp=S1(ii,:,jj);
        s1(ii,jj,1)= mean(temp);
        s1(ii,jj,2)= var(temp);
        s1(ii,jj,3)= skewness(temp);
        s1(ii,jj,4)= kurtosis(temp);
        s1(ii,jj,5)= wentropy(temp,'shannon');
        s1(ii,jj,6)= wentropy(temp,'log energy');
        s1(ii,jj,7)= mean(temp.^2);
        
        Ftemp=abs(fft(temp));
        s1(ii,jj,8)= mean(Ftemp);
        s1(ii,jj,9)= var(Ftemp);
        s1(ii,jj,10)= skewness(Ftemp);
        s1(ii,jj,11)= kurtosis(Ftemp);
%         s1(ii,jj,12)= wentropy(Ftemp,'shannon');
        s1(ii,jj,12)= wentropy(Ftemp,'log energy');
        s1(ii,jj,13)= mean(Ftemp.^2);
    end
end
clear temp Ftemp
%%
for ii=1:30
    for jj=1:71
        temp=S2(ii,:,jj);
        s2(ii,jj,1)= mean(temp);
        s2(ii,jj,2)= var(temp);
        s2(ii,jj,3)= skewness(temp);
        s2(ii,jj,4)= kurtosis(temp);
        s2(ii,jj,5)= wentropy(temp,'shannon');
        s2(ii,jj,6)= wentropy(temp,'log energy');
        s2(ii,jj,7)= mean(temp.^2);
        
        Ftemp=abs(fft(temp));
        s2(ii,jj,8)= mean(Ftemp);
        s2(ii,jj,9)= var(Ftemp);
        s2(ii,jj,10)= skewness(Ftemp);
        s2(ii,jj,11)= kurtosis(Ftemp);
%         s2(ii,jj,12)= wentropy(Ftemp,'shannon');
        s2(ii,jj,12)= wentropy(Ftemp,'log energy');
        s2(ii,jj,13)= mean(Ftemp.^2);
    end
end

clear K1 K2 S1 S2 ii jj temp Ftemp
%% Subject #1

trn1=k1(:,1:50,:);
tst1=k1(:,51:end,:);
trn2=k2(:,1:50,:);
tst2=k2(:,51:end,:);

trn=cat(2,trn1,trn2);
tst=cat(2,tst1,tst2);

l1=ones(1,50);
l2=ones(1,50).*2;
trnL=cat(2,l1,l2);
l1=ones(1,20);
l2=ones(1,21).*2;
tstL=cat(2,l1,l2);

% for ii=1:30
%     tempTRN(:,:)=trn(ii,:,:);
%     tempTST(:,:)=tst(ii,:,:);
%     
%     mdl=fitcsvm(tempTRN,trnL);
%     O=predict(mdl,tempTST);
%     
%     acr=(O'==tstL);
%     acr=sum(acr)/size(acr,2);
%     ACR(ii)=acr*100;
%     
%     ACR(ii)
%     
%     clear tempTRN tempTST mdl O acr
% end

clearvars -except s1 s2 k1 k2
%% Subject #2

trn1=s1(:,1:50,:);
tst1=s1(:,51:end,:);
trn2=s2(:,1:50,:);
tst2=s2(:,51:end,:);

trn=cat(2,trn1,trn2);
tst=cat(2,tst1,tst2);

l1=ones(1,50);
l2=ones(1,50).*2;
trnL=cat(2,l1,l2);
l1=ones(1,20);
l2=ones(1,21).*2;
tstL=cat(2,l1,l2);

% for ii=1:30
%     tempTRN(:,:)=trn(ii,:,:);
%     tempTST(:,:)=tst(ii,:,:);
%     
%     mdl=fitcsvm(tempTRN,trnL);
%     O=predict(mdl,tempTST);
%     
%     acr=(O'==tstL);
%     acr=sum(acr)/size(acr,2);
%     ACR(ii)=acr*100;
%     
%     ACR(ii)
%     
%     clear tempTRN tempTST mdl O acr 
% end

clearvars -except s1 s2 k1 k2
%% both subjects 

trnK1=k1(:,1:50,:);
trnK2=k2(:,1:50,:);
trnS1=s1(:,1:50,:);
trnS2=s2(:,1:50,:);
tstK1=k1(:,51:70,:);
tstK2=k2(:,51:71,:);
tstS1=s1(:,51:70,:);
tstS2=s2(:,51:71,:);

trn1=cat(2,trnK1,trnS1);
trn2=cat(2,trnK2,trnS2);
tst1=cat(2,tstK1,tstS1);
tst2=cat(2,tstK2,tstS2);

TRN=cat(2,trn1,trn2);
TST=cat(2,tst1,tst2);


trnL1=ones(1,100);
trnL2=ones(1,100).*2;
tstL1=ones(1,40);
tstL2=ones(1,42).*2;

trnL=cat(2,trnL1,trnL2);
tstL=cat(2,tstL1,tstL2);




for ii=1:30
    tempTRN(:,:)=TRN(ii,:,:);
    tempTST(:,:)=TST(ii,:,:);
    
    mdl=fitcsvm(tempTRN,trnL);
    O=predict(mdl,tempTST);
    
    acr=(O'==tstL);
    acr=sum(acr)/size(acr,2);
    ACR(ii)=acr*100;
    
    ACR(ii)
    
    clear tempTRN tempTST mdl O acr 
end

