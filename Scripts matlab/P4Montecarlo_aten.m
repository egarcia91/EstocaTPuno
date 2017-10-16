clear all; close all; clc;

pkg load communications; %Para que funcione en Octave

% Montecarlo A=10%

% Repetidor Digital %

N = 20000; %Iteraciones
S = 0; %Sumador para indicadora de error
A = 10; 
k = 1;
H = 0.9;

for SNRdB = 5 : 25

	SNR = 10^(SNRdB/10);

	sigma = H*A/(sqrt(SNR));

	for j = 1 : N

		U = rand(1);  %Genero X inicial con distr. Ber(1/2)
		if U<0.5
			X1 = -A;
		else
			X1 = A;
		end

		X = X1;

		for i = 1 : 9   % 9 repetidores 
			W = (sigma)*randn(1);
			Y = H*X+W;
			if Y<0  % Decision
				X = -A;
			elseif Y > 0
				X = A;
			end
		end

		if X ~= X1 % Si la salida es distinta que el inicial, sumo un evento de error
			S = S+1;
		end

	end

	PeDig(k) = S/N;  % Prob de error (estimada) para cada SNR
	k = k+1;
	S = 0; % Reseteo para proxima iteracion %
end

k = 1;

% Busco PeDigital teorico para comparar con PeDigital del Montecarlo %

for SNRdBp = 5 : 25
	SNRp = 10.^(SNRdBp/10);
	PeDigTeorica(k) = (1/2)*(1-((1-(2*qfunc(sqrt(SNRp)))).^9));
	k = k+1;
end

% Grafico para comparar %

% Graficar en Octave
%hf = figure();
%plot(5:25, PeDig);
%hold on;
%plot(5:25, PeDigTeorica);
%print -djpg comparacionDigital.jpg;
%close;

figure;
semilogy(5:25,PeDig,'b');
ylim([10^-6  1]);
hold on;
semilogy(5:25,PeDigTeorica,'k');
ylim([10^-6  1]);
xlabel('SNR');
ylabel('Probabilidad de error');
legend('Curva simulada','Curva te�rica','location','NorthEastOutside');
title('Repetidor Digital - Monte Carlo vs. Probabilidad Te�rica');
grid minor;

% Repetidor Analogico %

k = 1;
S = 0;

for SNRdB = 5 : 25

	SNR = 10^(SNRdB/10);

	sigma = A*H/(sqrt(SNR));

	%G=(A*H)/sqrt(((A*H)^2)+(sigma^2));
	G = sqrt(SNR/(SNR+1));

	for j = 1 : N

		U = rand(1);
		if U<0.5
			X1 = -A;
		else
			X1 = A;
		end

		X = X1;

		for i = 1 : 8 % 8 repetidores para que sea n=9 %
			W = (sigma)*randn(1);
			Y = (H*X)+W;
			X = G*Y;
		end

		W = (sigma)*randn(1);
		Y = (H*X)+W;

		if Y<0  % Decision final
			X = -A;
		elseif Y>0
			X = A;
		end

		if X ~= X1
			S = S+1;
		end

	end

	PeAnalog(k) = S/N;
	k = k+1;
	S = 0;
end

% Busco SNRn teorico para verificar PeAnalogica y armo vector %

k = 1;

for SNRprueba = 5 : 25

	SNRp = 10^(SNRprueba/10);

	sigma = (H*A)/(sqrt(SNRp));

	G = sqrt(SNRp/(SNRp+1));

	%G=(A*H)/sqrt(((A*H)^2)+(sigma^2));
	Sum = 1;

	for j = 1 : 8
		Gprod = 1;
		for i = (j+1) : 9
			Gprod = Gprod*G;
		end
		Gprod = Gprod^2;
		Sum = Sum+Gprod;
	end

	VarRuido = Sum*sigma^2;
	Gprod = 1;

	for i = 2 : 9
		Gprod = Gprod*G;
	end

	SNRn = ((Gprod^2)*(A^2)*(H^2))/VarRuido;

	PeAnalogTeorico(k) = qfunc(sqrt(SNRn)); 
	k = k+1;
end

% Graficar en Octave
%hf = figure();
%plot(5:25, PeAnalog);
%hold on;
%plot(5:25, PeAnalogTeorico);
%print -djpg comparacionAnalogica.jpg;
%close;

figure;
semilogy(5:25,PeAnalog,'r');
ylim([10^-6  1]);
hold on;
semilogy(5:25,PeAnalogTeorico,'k');
ylim([10^-6  1]);

xlabel('SNR');
ylabel('Probabilidad de error');
legend('Curva simulada','Curva te�rica','location','NorthEastOutside');
title('Repetidor Anal�gico - Monte Carlo vs. Probabilidad Te�rica');
grid minor;