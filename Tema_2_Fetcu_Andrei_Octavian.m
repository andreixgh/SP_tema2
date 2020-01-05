syms t;        %declarare t de tip simbolic
T = 40;        %perioada
w0 = 2*pi/T;   %pulsatie

f = heaviside(t) - heaviside(t - 9);    %functia treapta pentru compunerea semnalului dreptunghiular cu duty cycle 9/40

N = 50;   %numarul de coeficienti

[a0, a, b] = Functie_Tema_2_Fetcu_Andrei_Octavian(f, T, N);    %apelarea functiei

t_num = [-50:0.02:50]; %intervalul pentru semnalul reconstruit
f_num = a0;            %initializarea functiei cu a0
t1 = [-50:0.02:50];    %intervalul pentru semnalul dreptunghiular
freq = 0.025;          %frecventa semnalului dreptunghiular
square_wave = 0.5 + 0.5 * square(2*pi*freq.*t1, 22.5);   %crearea semnalului dreptungiular

for n = 1:N
    arm = a(n)*cos(n*w0*t_num) + b(n)*sin(n*w0*t_num);
    f_num = f_num + arm;    %adunarea fiecarei armonici la serie
    subplot(3, 1, 2)
    plot(t1, square_wave)
    title('x(t) (albastru) si reconstructia folosind N coeficienti (rosu)')
    hold on
    plot(t_num, f_num, 'red')  %afisarea semnalelor suprapuse(original si reconstruit)
    hold off
end

hold on
subplot(3, 1, 1)
plot(t1, square_wave)  %afisarea semnalului dreptunghiular
title('Semnal dreptunghiular')
hold off

for n = 1:N
    An(n) = sqrt(a(n)^2+b(n)^2); %calculul amplitudinilor
end

x = [fliplr(An) a0 An];
k = -N:1:N;
subplot(3, 1, 3)
stem(k, x)  %afisarea spectrului
hold on
plot(k, x)
title('Spectrul de amplitudini')

%Rezultatele obtinute sunt cele 2 semnale afisate si spectrul de
%amplitudini, acestea fiind in concordanta cu datele din cerinta.
%Conform celor invatate la cursul de Semnale si Sisteme, spectrul de
%amplitudini porneste de la o valoare maxima, amplitudinile armonicelor
%scazand pe masura ce creste indicele n.
