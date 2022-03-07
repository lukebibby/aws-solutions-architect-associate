# Virtual Private Cloud



## NACLs vs Security Groups
NACLs are stateless filters, whereas security groups are stateful.

A security group only includes permit rules, with an implicit deny at the end of the processing order.

A NACL can include deny rules. One example could be blocking all traffic from a range of IP addresses, which could only be done with a security group.

*Exam Tips*: 
 - If the question asks for denying traffic, a NACL can be used
 - If the question asks about blocking traffic between instances, use a security group