# OTCP_Quad
An Off-policy Reinforcement Learning Algorithm for Optimal Tracking Control Problem

In this project, the optimal tracking control problem for the quadrotor which is a highly coupling system with completely unknown dynamics is addressed based on data by introducing the
reinforcement learning (RL) technique. The proposed Off-policy RL algorithm does not need any
knowledge of the quadrotor model. By collecting data, which is the states of the quadrotor system then
using an actor-critic network (NNs) to solve the optimal tracking trajectory problem. Finally,
simulation results are provided to illustrate the effectiveness of the proposed method.

1. Problem Statement
2. Proposed Control Strategy
  2.1. Position Controller with Off-policy RL
  2.2. Attitude Controller with Off-policy RL
3. Simulation
Consider a quadrotor with the desired trajectory as a spiral trajectory
In the first stage, we use 2 PID controllers for both outer and inner loops to collect data for the next
stage of training to obtain the optimal controllers. Note that noises are added to the system to guarantee
the PE condition.
The position tracking error in this stage is illustrated in Fig 3.
Then, we use the data as the input to the algorithms which are proposed in the previous section. The
convergences of the weights are shown in Fig 4.
After we obtain the weights, estimated optimal controllers are applied to the object. The tracking
performance is illustrated in Fig 5.
4. Conclusion
In this project, a novel control strategy that consists of the Off-policy RL algorithm was proposed. By
collecting data to train two actor-critic networks (NNs) which aim to estimate the optimal controllers
which includes a position controller and attitude controller, this structure has the advantage of no need
of any prior information on the high coupling system. Finally, simulation results are provided to
illustrate the tracking performance of a sophisticated trajectory of the system.

