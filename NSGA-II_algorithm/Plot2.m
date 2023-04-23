function Plot2(pop)

    Costs = [pop.Cost];
    plot(Costs(1, :), Costs(2, :), 'r*', 'MarkerSize', 8);
    xlabel('1^{st} Producción energía eólica');
    ylabel('2^{nd} Producción energía solar');
    title('f1 vs f2)');
    grid on;

end