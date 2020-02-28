## Senior Project in Data Science Proposal Summary
### Periodic Attributes Encoding Study
#### *Jim Greene*
---
## Personal Background
I have completed the capstone courses MATH 425, CS 450, and MATH 488. I love data science in general but have a particular interest in automated processes and predicting functions. After graduation, I may proceed to work at INL; in which case, I would begin working on a graduate program earlier than if employed in a non-academic setting.

## Project Proposal Background
The topic of this project is one that has gotten my attention while working at INL. Lots of variables are periodic in nature: Time related cycles (seasons, day/night, etc.), certain physical processes (including rotating bodies), and virtual wraparound spaces. A few approaches exist for managing these attributes in machine learning algorithms. Most if not all encoding of cyclical variables for neural networks involves taking the sin and cosine of the variable, mapping it to a circle in two dimensions. Other algorithms which involve distance metrics require calculations that are careful to minimize spacial distortion. A strong candidate metric I've identified is the arc-length across these attributes. Having a distance metric that preserves the information of periodic variables helps in deriving new variables of interest. The purpose of the project will be to obtain and share knowledge in this topic with example code for future data science projects.

## Domain to Investigate
Clustering algorithms are among the most obvious to benefit from knowing how to use periodic attributes without losing information about the Euclidean distances in the initial space. In the article [K-Means Clustering for Problems with Periodic Attributes](https://www.academia.edu/19183509/K-MEANS_CLUSTERING_FOR_PROBLEMS_WITH_PERIODIC_ATTRIBUTES), the distance between two points is found using the minimum differences in each periodic attribute. Since no distortions are created, this is sufficient; but I will perform some further research to find if there are better or equally good approaches for clustering problems. Neural networks are capable of learning non-linear relationships, so the trigonometric encoding may be enough for them. However, if the arc-length metric can be implemented appropriately, it could reduce training time the same way scaling does. I am particularly interested in the arc-length metric and would like to demonstrate a lightweight proof for its use. Understanding and explaining it geometrically poses some challenges, because any more than one periodic variable and one non-periodic requires the use of four or more dimensions.

## Proposed Deliverables
I would like to build this in the form of an HTML document (which can be used on my website when I update it) or Medium post. I would also include a repository with some example code for implementations. When presenting at R&CW, I will want to add much of this content to PowerPoint slides. The final result will likely contain some information about the arc-length metric and when it is useful and a survey of algorithms and how periodic attributes should be used with them. An alternative to studying several algorithms could be to emphasize in the use of neural networks.

## Faculty Request
The three individuals I would first reach out to for help would be J Hathaway, Scott Burton, and David Palmer. Scott Burton may be the preferred faculty member for this project, because he has spent a lot of time studying machine learning and would have some good advice.
