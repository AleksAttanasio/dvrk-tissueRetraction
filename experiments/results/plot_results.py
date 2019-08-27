# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data = pd.read_csv('results.csv')
pre_std = data.iloc[1,[0,2,4]].values
pre_means = data.iloc[0,[0,2,4]].values
post_std = data.iloc[1,[1,3,5]].values
post_means = data.iloc[0,[1,3,5]].values

fig = plt.figure()
ax = fig.add_subplot(111)

N = 3
ind = np.arange(N)
width = 0.35 
    
rects1 = ax.bar(ind, pre_means, width,
                yerr=pre_std,
                error_kw=dict(elinewidth=1))

rects2 = ax.bar(ind+width, post_means, width,
                    yerr=post_std,
                    error_kw=dict(elinewidth=1))

ax.set_xlim(-width,len(ind))
ax.set_ylim(0,100)
ax.set_ylabel('Percentage of Visible Background')
ax.set_title('Retraction Results')
xTickMarks = ['Left', 'Right', 'Bottom']
ax.set_xticks(ind+width)
xtickNames = ax.set_xticklabels(xTickMarks)
plt.setp(xtickNames, rotation=45, fontsize=10)

ax.legend( (rects1[0], rects2[0]), ('Before Retraction', 'After Retraction') )