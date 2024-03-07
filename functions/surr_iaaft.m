%% iterative amplitude adjusted fourier tranform surrogates 
% algoritmo di Schreiber e Schmitz - Physical Review Letters 1996

% y: serie da surrogare
% nit: numero di iterazioni volute (default 7)
% stop: se metto 'spe' esce con lo spettro conservato, se metto 'dis' esce con la distribuzione conservata

function ys=surr_iaaft(y,nit,stop)

error(nargchk(1,3,nargin));%min e max di input arguments
if nargin < 3, stop='spe'; end %default matcha lo spettro
if nargin < 2, nit=7; end %default 7 iterazioni

[ysorted,~]=sort(y); % from the lowest to the highest value
my=abs(fft(y));
ys=surrshuf(y); % shuffling

for i=1:nit
    % step 1: impone lo spettro
    faseys=angle(fft(ys));
    fys=my.*(cos(faseys)+1i*sin(faseys));
    ys=ifft(fys); ys=real(ys);
    ys=ys-mean(ys);

    % step 2: impone la distribuzione
    [~,ysindice]=sort(ys);
    ypermuted=zeros(length(y),1);
    for ii=1:length(y)
        ypermuted(ysindice(ii))=ysorted(ii);
    end
    ys=ypermuted;

end

%se volevo conservare lo spettro, faccio 1 altro mezzo giro dove impongo solo quello
if stop == 'spe'
    faseys=angle(fft(ys));
    fys=my.*(cos(faseys)+1i*sin(faseys));
    ys=ifft(fys);ys=real(ys);
    ys=ys-mean(ys);
end



