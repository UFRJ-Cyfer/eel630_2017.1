% https://www.kaggle.com/c/digit-recognizer/data
dataset = csvread('train.csv',1,0);
labels = dataset(:,1);
dataset = dataset(:,2:end);
dataset(dataset < 128) = 0;
dataset(dataset >=128) = 1;
numbers = reshape(dataset,42000,28,28);
indexes = 1:42000;

moments = struct;
moments(10).firstOrder = [];
moments(10).secondOrder = [];

for digits = 0:9
    chosenIndexes = indexes(labels==digits);
    moments(digits+1).firstOrder = zeros(1,length(chosenIndexes));
    moments(digits+1).secondOrder = zeros(1,length(chosenIndexes));
    
    for k=1:length(chosenIndexes)
        moments(digits+1).firstOrder(k) = momentCalculator( 1, 1, reshape(numbers(chosenIndexes(k),:,:),28,28) , 1);
        moments(digits+1).secondOrder(k) = momentCalculator( 2, 2, reshape(numbers(chosenIndexes(k),:,:),28,28) , 1);
    end
    digits
end

% for k=0:9
%     status = mkdir(['images/' num2str(k)])
% end

digits = 1:10;
for k=1:10
    for j = digits(digits~=k)
        figure(99);
        plot(moments(k).firstOrder,moments(k).secondOrder,'.','Marker','+'); hold on;
        plot(moments(j).firstOrder,moments(j).secondOrder,'.','Marker','o'); hold off;

        legend(['D' num2str(k-1)], ['D' num2str(j-1)]);
        xlabel('\mu(1,1)', 'interpreter' ,'tex');
        ylabel('\mu(2,2)', 'interpreter' ,'tex');
        saveas(gcf,['images/' num2str(k-1) '/' num2str(k-1) '_' num2str(j-1)],'png')
    end
end


