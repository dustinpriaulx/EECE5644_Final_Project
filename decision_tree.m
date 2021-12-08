data = framinghamclean(:,1:15);
CHD_ind = framinghamclean(:,16);

rng(1);
decision_tree = fitctree(data, CHD_ind, 'MaxNumSplits', 10, 'CrossVal', 'on')
view(decision_tree.Trained{1},'Mode','graph')

classError = kfoldLoss(decision_tree)

%%
decision_tree2 = fitctree(data, CHD_ind, 'MaxNumSplits', 6, 'CrossVal', 'on')
view(decision_tree2.Trained{1},'Mode','graph')

classError2 = kfoldLoss(decision_tree2)