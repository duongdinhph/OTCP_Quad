# Optimal tracking control for unknown-dynamics quadrotor with an Off-policy Reinforcement Learning algorithm
An Off-policy Reinforcement Learning Algorithm for Optimal Tracking Control Problem       
Full report: [link](https://drive.google.com/drive/folders/1LOUQExAoRkOGeKZ26fC8hELxbSGDK5ZK)
# 1. Introduction
This project presents a comprehensive approach to integrating formation tracking control and optimal control for a fleet of multiple surface vehicles (SVs),
accounting for both kinematic and dynamic models of each SV agent. The
proposed control framework comprises two core components: a high-level
displacement-based formation controller and a low-level reinforcement learning (RL)-based optimal control strategy for individual SV agents. The high-level
formation control law, employing a modified gradient method, is introduced to
guide the SVs in achieving desired formations. Meanwhile, the low-level control structure, featuring time-varying references, incorporates the RL algorithm
by transforming the time-varying closed agent system into an equivalent
autonomous system. The application of Lyapunov’s direct approach, along with
the existence of the Bellman function, guarantees the stability and optimality of
the proposed design. Through extensive numerical simulations, encompassing
various comparisons and scenarios, this study demonstrates the efficacy of the
novel formation control strategy for multiple SV agent systems, showcasing its
potential for real-world applications.

# 2. Proposed Control scheme


In this section, we present the model of the quadrotor and the traditional control scheme. A quadrotor could be described with dynamic equations: $m = T_p R e_{3,3} - m g e_{3,3} $

Where: 
The position of the center of mass is $p = [p_x,p_y,p_z]^T \in \mathbb{R}^3$. The Euler angles $\Theta = [\phi, \theta, \psi]$. $e_{i,j}$ is the vector which has $i$ numbers of zeros except for number 1 in the $j^{th}$ position.

# 2. Proposed Control Strategy
![Quad_Control_Diagram](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/306f37f3-1ca5-46a6-9e22-f797f3e7797e)
  ## 2.1. Position Controller with Off-policy RL
  
  ## 2.2. Attitude Controller with Off-policy RL
  
# 3. Simulation
![3D_tracking_skew](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/5f818f3d-f018-494b-a6ec-4f97d2e55295)

Consider a quadrotor with the desired trajectory as a spiral trajectory
In the first stage, we use 2 PID controllers for both outer and inner loops to collect data for the next
stage of training to obtain the optimal controllers. Note that noises are added to the system to guarantee
the PE condition.

![xyz_wrt_ref](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/be6b3386-5f5b-419b-b4d3-0e306fc9f110)

The position tracking error in this stage is illustrated in the figure above.
Then, we use the data as the input to the algorithms which are proposed in the previous section. The
convergences of the weights are shown in the figure above.
After we obtain the weights, estimated optimal controllers are applied to the object. The tracking
performance is illustrated in figure above.
# 4. Conclusion
In this project, a novel control strategy that consists of the Off-policy RL algorithm was proposed. By
collecting data to train two actor-critic networks (NNs) which aim to estimate the optimal controllers
which includes a position controller and attitude controller, this structure has the advantage of no need
of any prior information on the high coupling system. Finally, simulation results are provided to
illustrate the tracking performance of a sophisticated trajectory of the system.


