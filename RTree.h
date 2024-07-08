#ifndef __RTREE_H
#define __RTREE_H
#include <stdio.h>
#include "Def.h"
#include "RList.h"
#include "PQueue.h"

int sorter;



Region RinitRgnRect(Dimension iBottomLeft, Dimension iTopRight);
void RsetRect(RLstNd lstNd, RTreeNode tnInfo);

RTreeNode RinitExtNd(Data dataClstElem);
RTreeNode RinitIntNd(Dimension iBottomLeft, Dimension iTopRight);

Boolean RexpansionArea(Region rgnRect, RTreeNode tnInfo, Double ptrDMinExp, Region rgnNewRect);
double Rarea(Region rgnRect);

RLstNd RpickChild(RHdrNd ptrChildLst, RTreeNode tnInfo);
void RpickSeeds(RHdrNd ptrChildList, RLstNd *lstNdChildOne, RLstNd *lstNdChildTwo);
void RsplitNode(RLstNd ptrChild);

Boolean RinsertTree(RHdrNd hdrNdTree, RTreeNode tnInfo);
RHdrNd RbuildRTree(DataHdr dataHdrLst);
RHdrNd RbuildWRTree(DataHdr dataHdrLst,unsigned start,unsigned int end);
RHdrNd buildLRTreeN(DataHdr dataHdrLst,unsigned int n);
RHdrNd buildLRTree(DataHdr dataHdrLst);
RHdrNd buildPRTree(DataHdr* dataHdrLst);

RHdrNd buildLRTreeStatic(DataHdr dataHdrLst);

RHdrNd RcreateRoot(RHdrNd hdrNdTree);

void RprintTree(RHdrNd hdrNdTree);

unsigned int RgetNeighborHood(RHdrNd hdrNdTree, Data dataNdTemp);
double RfindDist(DataPoint iDataOne, DataPoint iDataTwo);
unsigned int RfindRecords(RHdrNd hdrNdTree, Region rgnRect, Data dataNdTemp);

Boolean RisContains(Region rgnRect, DataPoint iData);
Boolean RisOverLap(Region rgnRectOne, Region rgnRectTwo);

void RappendRTree(RHdrNd hdrNdTree, DataHdr dataHdrLst);
void freeRTree(RHdrNd hdrNdTree);


Data RgetOneNN(RHdrNd hdrNdTree, Data dataPoint, DataHdr dataList);
Data * RgetKNN(RHdrNd hdrNdTree, Data dataPoint, DataHdr dataList, int k);
double calculateMinDistance(Data datapoint, Region region);
double calculateDistance(DataPoint iDataOne, DataPoint iDataTwo);

#endif
