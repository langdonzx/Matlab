% Definição das funções de transferência
Gc = tf(1, [1 2 0]);  % Gc(s) = K/(s(s+2))
F = tf(10, [1 10]);    % F(s) = 10/(s+10)

% Função de transferência do sistema em malha fechada
T = feedback(Gc*F, 1);

% Definição da entrada rampa unitária
R = tf([1 0], 1);

% Simulação da resposta ao degrau unitário
figure;
step(T*R);  % Resposta ao degrau unitário
title('Resposta ao degrau unitário');

% Verificação da estabilidade variando K
K_values = linspace(0, 100, 1000);
stability = zeros(size(K_values));
for i = 1:length(K_values)
    Gc_temp = tf([K_values(i)], [1 2 0]);  % Gc(s) = K/(s(s+2))
    T_temp = feedback(Gc_temp*F, 1);
    poles = pole(T_temp);
    stability(i) = all(real(poles) < 0);  % Verifica se todas as partes reais dos polos são negativas
end

% Encontrando o valor de K para estabilidade
stable_K = K_values(find(stability, 1, 'last'));

disp(['O valor de K para estabilidade é: ' num2str(stable_K)]);