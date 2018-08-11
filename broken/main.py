import matplotlib.pyplot as plt
import math
import random

centroids = []
clusters = []
data = [[1,1],[3,2],[1,2],[2,2],[1,1],[3,1],[4,2],
                    [10,11],[13,14],[12,10],[11,13],[15,11]]

numGroups = 2

iterations = 1000

maxx = 100
maxy = 100

def findDistance(x1, y1, x2, y2):
    return math.sqrt(math.pow(x1-x2,2)+math.pow(y1,y2))

def adjustclusters():
    clusters = []

    for x in range(0,numGroups):
        clusters.append([])

    for x in range(0,len(data)):
        bestDistance = 10000000000000 #need to do this better
        bestIndex = None
        point = data[x]

        for y in range(0, len(centroids)):
            centroid = centroids[y]
            distance = findDistance(centroid[0], centroid[1], point[0], point[1])

            if distance < bestDistance:
                bestIndex = y
                bestDistance = distance

        clusters[bestIndex].append(point)

def adjustcentroids():
    for x in range(0,len(clusters)):
        cluster = clusters[x]
        avgX = 0
        avgY = 0

        for point in cluster:
            avgX += point[0]
            avgY += point[1]

        avgX /= len(clusters)
        avgY /= len(clusters)

        centroids[x][0] = avgX
        centroids[x][1] = avgY


def graph():
    for centroid in centroids:
        plt.scatter(centroid[0],centroid[1])

    plt.show()

def start():
    for x in range(0,numGroups):
        point = [0,0]
        point[0] = random.randrange(maxx)
        point[1] = random.randrange(maxy)

        centroids.append(point)


    for x in range(0,iterations):
        adjustcentroids()
        adjustclusters()
    graph()


if __name__== "__main__":
  start()

