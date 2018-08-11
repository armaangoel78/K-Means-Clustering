double[][] data;
ArrayList<ArrayList<double[]>> clusters;
double[][] centroids;

int clusterNum = 2;
//int iteration = 1000;
int maxX = 20, maxY = 20, resize = 25;


void setup() {
  size(600, 600);
  smooth();
  data = new double[][]{{1,1},{3,2},{1,2},{2,2},{1,1},{3,1},{4,2},
                    {10,11},{13,14},{12,10},{11,13},{15,11}};
  
  clusters = new ArrayList<ArrayList<double[]>>();
  centroids = new double[clusterNum][2];
  
  for (int i = 0; i < clusterNum; i++) { 
    clusters.add(new ArrayList<double[]>());
    centroids[i][0] = random(maxX+1);
    centroids[i][1] = random(maxY+1);
  } 
}

void adjustCentroids() { 
  for (int i = 0; i < clusters.size(); i++) { ;
    
    ArrayList<double[]> cluster = clusters.get(i);
    if (cluster.size() > 0) {
      int avgX = 0, avgY = 0;
      for (double[] data : cluster) {
        avgX += data[0];
        avgY += data[1];
      }
      
      avgX = avgX/cluster.size();
      avgY = avgY/cluster.size();
      
      centroids[i][0] = avgX;
      centroids[i][1] = avgY;
    }
  }
} 

void adjustClusters() {
  clusters = new ArrayList<ArrayList<double[]>>();
  
  for (int i = 0; i < clusterNum; i++) { 
    clusters.add(new ArrayList<double[]>());
  } 
  
  for (int i = 0; i < data.length; i++ ) {
      double bestDistance = 1000000; //TODO: fix this num 
      int bestCluster = -1;
      for (int y = 0; y < centroids.length; y++) {
        double distance = distance(centroids[y][0], centroids[y][1], data[i][0], data[i][1]); 
        if (distance < bestDistance) { 
          bestDistance = distance; 
          bestCluster = y; 
        }
      }       
      clusters.get(bestCluster).add(data[i]); 
  }
}

double distance(double x1, double y1, double x2, double y2) {
   return sqrt(sq((float)(x1-x2))+sq((float)(y1+y2)));
}

void draw() {
  adjustClusters();
  adjustCentroids();
  
  background(#000000);
    
  stroke(#ffffff);
  for (ArrayList<double[]> cluster : clusters) { 
    for (double[] dataPoint : cluster) { 
      ellipse((float)dataPoint[0]*resize, (float)dataPoint[1]*resize, 5, 5);
    } 
  } 
  
  stroke(#000fff);
  for (double[] centroid : centroids) {
    ellipse((float)centroid[0]*resize, (float)centroid[1]*resize, 5, 5);
  } 
}
