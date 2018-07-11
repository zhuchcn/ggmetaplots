# file = "~/Box Sync/UC Davis/Right Now/Researches/Zivkovic Lab/Egg Study/Result/Analysis/hdl/Rdata/lpd_precalc.Rdata"
# load(file)
# mset = lipidome_set$class$Adjusted
# df = data.frame(
#     x = conc_table(mset)["Cholesterol",],
#     Timepoint = sample_table(mset)$Timepoint,
#     Treatment = sample_table(mset)$Treatment,
#     Subject = sample_table(mset)$Subject
# )
#
# ggplot(df, aes(y = x)) +
#     geom_boxplot() +
#     facet_grid(cols = vars(Timepoint), rows = vars())
#
# myplot = function(data, x, y, cols){
#     ggplot(data, aes(x=!!(enquo(x)), y = !!(enquo(y)))) +
#         geom_boxplot() +
#         facet_grid(cols = vars(!!enquo(cols)))
# }
#
# ggboxplot(data = df, x = "Timepoint", y = "x")
