# OTCP_Quad
An Off-policy Reinforcement Learning Algorithm for Optimal Tracking Control Problem
# Introduction
In this project, the optimal tracking control problem for the quadrotor which is a highly coupling system with completely unknown dynamics is addressed based on data by introducing the
reinforcement learning (RL) technique. The proposed Off-policy RL algorithm does not need any
knowledge of the quadrotor model. By collecting data, which is the states of the quadrotor system then
using an actor-critic network (NNs) to solve the optimal tracking trajectory problem. Finally,
simulation results are provided to illustrate the effectiveness of the proposed method.

# 1. Problem Statement
![quad_schematic](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/9de3f13d-e145-4d17-8df4-7d9a2c6e777b)

In this section, we present the model of the quadrotor and the traditional control scheme. A quadrotor could be described with dynamic equations:
$ m =  T_pRe_{3,3} - mge_{3,3} $
Where: 
The position of the center of mass is $p = [p_x,p_y,p_z]^T \in \mathbb{R}^3$. The Euler angles $\Theta = [\phi, \theta, \psi]$. $e_{i,j}$ is the vector which has $i$ numbers of zeros except for number 1 in the $j^{th}$ position.

# 2. Proposed Control Strategy
![Quad_Control_Diagram](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/306f37f3-1ca5-46a6-9e22-f797f3e7797e)
  ## 2.1. Position Controller with Off-policy RL
  
  ## 2.2. Attitude Controller with Off-policy RL
  
# 3. Simulation
![3D_tracking](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/af2a8f56-eb79-42a8-b9a3-ebe06947d5d0)

Consider a quadrotor with the desired trajectory as a spiral trajectory
In the first stage, we use 2 PID controllers for both outer and inner loops to collect data for the next
stage of training to obtain the optimal controllers. Note that noises are added to the system to guarantee
the PE condition.

![trajectory](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/f897a547-6174-4f9d-89cb-ae739c857a10)

The position tracking error in this stage is illustrated in Fig 3.
Then, we use the data as the input to the algorithms which are proposed in the previous section. The
convergences of the weights are shown in Fig 4.
After we obtain the weights, estimated optimal controllers are applied to the object. The tracking
performance is illustrated in Fig 5.
# 4. Conclusion
In this project, a novel control strategy that consists of the Off-policy RL algorithm was proposed. By
collecting data to train two actor-critic networks (NNs) which aim to estimate the optimal controllers
which includes a position controller and attitude controller, this structure has the advantage of no need
of any prior information on the high coupling system. Finally, simulation results are provided to
illustrate the tracking performance of a sophisticated trajectory of the system.


