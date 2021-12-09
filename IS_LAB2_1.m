%Domantas Dvariškis
%KTfm-21
%2 Laboratorinis darbas pagrindinė užd.
%Netiesinio aproksimatoriaus mokymo algoritmas

%1. Duomenų paruošimas mokymui
x = [0.1:1/22:1];
d = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))./2; %Išėjime norimas atsakas
figure(1);
plot(x,d,'b*')
grid on;
%2. Pasirinkti struktūrą
%Pirmasis (paslėptasis) sluoksnis:
%Ryšių svoriai einantys į pirmą neuroną iš pirmo įėjimo
w11_1 = rand(1)*0.1; 
w21_1 = rand(1)*0.1;
w31_1 = rand(1)*0.1;
w41_1 = rand(1)*0.1;
w51_1 = rand(1)*0.1;
w61_1 = rand(1)*0.1;
%Neuronų koeficientai
b1_1 = rand(1)*0.1;
b2_1 = rand(1)*0.1;
b3_1 = rand(1)*0.1;
b4_1 = rand(1)*0.1;
b5_1 = rand(1)*0.1;
b6_1 = rand(1)*0.1;
%Antrojo sluoksnio (išėjimo)ryšių svoriai
w11_2 = rand(1)*0.1;
w12_2 = rand(1)*0.1;
w13_2 = rand(1)*0.1;
w14_2 = rand(1)*0.1;
w15_2 = rand(1)*0.1;
w16_2 = rand(1)*0.1;
b1_2 = rand(1)*0.1;

n = 0.1; %Mokymo žingsnis
for i = 1:100000 %Tinklo apmokymo pakartojimai
    for i = 1:length(x)
        %3. Skaičuojama tinklo atsaka
        %3.1 Pirmojo sluoksnio neuronams
        v1_1 = x(i)*w11_1 + b1_1; %Pasvertoji suma
        v2_1 = x(i)*w21_1 + b2_1;
        v3_1 = x(i)*w31_1 + b3_1;
        v4_1 = x(i)*w41_1 + b4_1;
        v5_1 = x(i)*w51_1 + b5_1;
        v6_1 = x(i)*w61_1 + b6_1;
        % Aktyvavimo funkcijos pritaikymas
        y1_1 = tanh(v1_1);
        y2_1 = tanh(v2_1);
        y3_1 = tanh(v3_1);
        y4_1 = tanh(v4_1);
        y5_1 = tanh(v5_1);
        y6_1 = tanh(v6_1);
        %3.2 Antrojo sluoksnio neuronui
        v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + y5_1*w15_2 + y6_1*w16_2;
        % Aktyvavimo funkcijos pritaikymas išėjimo neuronui
        y1_2 = v1_2;
        y = y1_2;
        %3.3 Skaičiuojama klaidą
        e = d(i) - y;
        %4 Ryšių svorių atnaujinimas
        %4.1 Skaičiuojama klaidos gradientą išėjimo sluoksnio neuronui
        delta1_2 = e;
        %4.2 Skaičiuojama klaidos gradientą paslėptojo sluoksnio neuronams
        delta1_1 = (1-(tanh(y1_1))^2)*delta1_2*w11_2;   %Aktyvavimo f-jos išvestinė dauginta iš antrojo sluoksnio delta
        delta2_1 = (1-(tanh(y2_1))^2)*delta1_2*w12_2;
        delta3_1 = (1-(tanh(y3_1))^2)*delta1_2*w13_2;
        delta4_1 = (1-(tanh(y4_1))^2)*delta1_2*w14_2;
        delta5_1 = (1-(tanh(y5_1))^2)*delta1_2*w15_2;
        delta6_1 = (1-(tanh(y6_1))^2)*delta1_2*w16_2;
        %4.3 Atnaujinamas išėjimo sluoksnio svoriai
        w11_2 = w11_2 + n.*delta1_2*y1_1;
        w12_2 = w12_2 + n.*delta1_2*y2_1;
        w13_2 = w13_2 + n.*delta1_2*y3_1;
        w14_2 = w14_2 + n.*delta1_2*y4_1;
        w15_2 = w15_2 + n.*delta1_2*y5_1;
        w16_2 = w16_2 + n.*delta1_2*y6_1;
        b1_2 = b1_2 + n*delta1_2;
        %4.4 Atnaujinamas paslėptojo sluosnio svoriai
        w11_1 = w11_1 + n*delta1_1*x(i);
        w21_1 = w21_1 + n*delta2_1*x(i);
        w31_1 = w31_1 + n*delta3_1*x(i);
        w41_1 = w41_1 + n*delta4_1*x(i);
        w51_1 = w51_1 + n*delta5_1*x(i);
        w61_1 = w61_1 + n*delta6_1*x(i);
        b1_1 = b1_1 + n*delta1_1;
        b2_1 = b2_1 + n*delta2_1;
        b3_1 = b3_1 + n*delta3_1;
        b4_1 = b4_1 + n*delta4_1;
        b5_1 = b5_1 + n*delta5_1;
        b6_1 = b6_1 + n*delta6_1;
    end
end

%Gaunamos tinklo reikšmės po apmokymo
X = [0.1:1/60:1];
Y = zeros(1,length(d));
for i = 1:length(X)
        %3. Skaičuojama tinklo atsaka
        %3.1 Pirmojo sluoksnio neuronams
        v1_1 = X(i)*w11_1 + b1_1;
        v2_1 = X(i)*w21_1 + b2_1;
        v3_1 = X(i)*w31_1 + b3_1;
        v4_1 = X(i)*w41_1 + b4_1;
        v5_1 = X(i)*w51_1 + b5_1;
        v6_1 = X(i)*w61_1 + b6_1;
        % aktyvavimo f-jos pritaikymas
        y1_1 = tanh(v1_1);
        y2_1 = tanh(v2_1);
        y3_1 = tanh(v3_1);
        y4_1 = tanh(v4_1);
        y5_1 = tanh(v5_1);
        y6_1 = tanh(v6_1);
        %3.2 Antrojo sluoksnio neuronai
        v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + y5_1*w15_2 + y6_1*w16_2;
        % aktyvavimo f-jos pritaikymas
        y1_2 = v1_2;
        y = y1_2;
        %3.3 Saugome tarpines reikšmes
        Y(i) = y;
        
end

hold on 
plot(X,Y,'r+')
hold off;
        
        
