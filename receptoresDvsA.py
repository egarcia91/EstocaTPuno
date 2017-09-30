#from scipy import stats
#import warnings
from scipy.stats import norm
#from scipy.stats import uniform
from scipy.stats import bernoulli

#Xuniforme = uniform()
Wnormal = norm()
Xber = bernoulli(0.5)

print "TP Uno de estoca!"
#print "Bounds of Normal distribution lower: %s, upper: %s" % (norm.a, norm.b)

#print "Acumulado de una Normal 0, 1: %s" % (Wnormal.cdf(0))
print "Numero al azar de una Normal 0, 1: %s" % (Wnormal.rvs())

#print "Bounds of Uniform distribution lower: %s, upper: %s" % (uniform.a, uniform.b)
#print "Bounds of Uniform distribution Cumulative Distribution Function: %s" % (Xuniforme.cdf(0.5))

print "Numero al azar de una Bernoulli de p = 0.5: %s" % (Xber.rvs())
