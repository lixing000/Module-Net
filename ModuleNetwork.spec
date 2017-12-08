score NormalGamma alpha=2 lambda=1 
Prior LeafPenalty 20
Prior RegulatorPenalty 15
data GeneExpressionFile TCGA_GBM_Agilent_Exp.txt regulators=candidate.List
assignmentAlgorithm GeronemoIteration
algorithm GreedyHillClimbing local
choiceTest GeronemoTest
