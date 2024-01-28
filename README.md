# Optimal tracking control for unknown-dynamics quadrotor with an Off-policy Reinforcement Learning(RL) algorithm
An Off-policy Reinforcement Learning Algorithm for Optimal Tracking Control Problem       
Full report: [link](https://drive.google.com/drive/folders/1LOUQExAoRkOGeKZ26fC8hELxbSGDK5ZK)
# 1. Introduction
In this project, the optimal tracking control problem (OTCP) for the quadrotor which is a highly coupling system with completely unknown dynamics is addressed based on data by introducing the reinforcement learning (RL) technique. The proposed Off-policy RL algorithm does not need any knowledge of the quadrotor model. By collecting data, which is the states and control inputs of the quadrotor system, then using an actor-critic network (NNs) to approximate the optimal controller, OTCP for the quadrotor is resolved. Finally, simulation results are provided to illustrate the effectiveness of the proposed method.

# 2. RL algorithm for Optimal tracking control problem of the affine system:
* Non-linear aﬀine system:
$$\dot{X}(t) = F(X(t)) + G(X(t))u(t)$$
* The cost function:
$$V(X(t))=\int_{t}^{\infty}e^{-\lambda(\tau-t)}[X(\tau)^TQX(\tau)+u(\tau)^TRu(\tau)]d\tau$$
The Rl algorithm comprises 3 steps:
* Step 1: Init
Start with a stable control signal $u_0$ and add a noise component $u_e$ to ensure the PE condition. Collect data and determine threshold $\epsilon$
* Step 2: Policy Evaluation and Policy Improvement:

$$ V^{i+1}(X(t+\delta t)) - V^{i+1}(X(t)) =  -\int_{t}^{t+\delta t}[X(\tau)^TQX(\tau)
					+ [u^i(X(\tau))]^TRu^i(X(\tau))]d\tau + \int_{t}^{t+\delta t}\lambda V^{i+1}(X(\tau))d\tau 
					+ 2\int_{t}^{t+\delta t}[u^{i+1}(X(\tau))]^TR[u^i(X(\tau)) - u(\tau)] d\tau $$


* Step 3: Checking convergence
Stop iterating if $\| u^{i+1}-u^i \| < \epsilon$, otherwise: update $u^i = u^{i+1}$, return to step (2).

# 3. The proposed control scheme applied for a quadrotor:
  ## 3.1. Dynamic model and general control scheme

![quad_schematic](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/8a8c3980-18f1-42e6-90e9-5f29923f5434)   
A quadrotor could be described with dynamic equations:   
$$m \ddot{p} = T_p R e_{3,3} - m g e_{3,3} $$   
$$J\ddot{\Theta} = \tau - C(\Theta,\dot{\Theta})\dot{\Theta}$$
Where:   
* The position of the center of mass is $p = [p_x,p_y,p_z]^T \in \mathbb{R}^3$
* The Euler angles $\Theta = [\phi, \theta, \psi]$.
* $e_{i,j}$ is the vector which has $i$ numbers of zeros except for number 1 in the $j^{th}$ position.
* $J = diag(J_x, J_y, J_z)$

A typical control scheme for quadrotor consists of a Position controller which generates desired trajectory for the inner control loop and an Attitude controller which tracks the desired attitude angles obtained from the outer loop control.   

![Quad_Control_Diagram](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/306f37f3-1ca5-46a6-9e22-f797f3e7797e)   


  ## 3.2. Position Controller with Off-policy RL
Rewrite the position equation in the form of an affine system:   

$$ \dot{x}_p = A_p x_p + B_p u_p $$   

where: $x_p = [p_x, \dot{p}_x, p_y, \dot{p}_y, p_z, \dot{p}_z]^T$   

  ## 3.3. Attitude Controller with Off-policy RL
Rewrite the attitude equation in the form of an affine system:   

$$\dot{x}_\Theta = F_\Theta x_\Theta + B_\Theta u_\Theta$$   

where: $x_\Theta = [\phi, \dot{\phi}, \theta, \dot{\theta}, \psi, \dot{\psi}]^T$   

  ## 3.4. The Actor-Critic Neural Network structure
The Actor-Critic Neural Network structure is introduced to estimate $V(X)$ and $u(X)$ as follows:   
$$ \hat{V}^i(X) = [w_V^i]^T \varphi(X) $$   
$$ \hat{u}^i(X) = [w_u^i]^T \psi(X) $$   

# 4. Simulation
Consider a quadrotor with the desired trajectory as a spiral trajectory
In the first stage, we use 2 PID controllers for both outer and inner loops to collect data for the next
stage of training to obtain the optimal controllers. Note that noises are added to the system to guarantee
the PE condition. The position and attitude tracking error in this stage is illustrated in the figures below.   
![ini_e_p](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/1ca120b3-983e-4208-ae59-06c62c7afd61)
![init_e_Teta](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/fcceb177-cecb-4968-9429-ea8589c4b0dc)

In the second stage, we use the data as the input to the RL algorithms proposed in the previous section. The convergence of the weights is shown in the figures below.   
![conver_p](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/4cd36ea7-d1dd-4869-a8c5-257a7421a823)
![conver_Teta](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/c0e6318a-8cf5-4741-87a1-d2ed0f18662b)

After we obtain the weights, estimated optimal controllers are applied to the object. The tracking performance is illustrated in the figures below.   
* The tracking error in position and attitude controller:
![op_e_p](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/66d31e5f-5613-45ff-96de-b4f84cc58361)
![op_e_Teta](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/a2494205-280d-4807-9ea4-90f927c0af91)
* The $x-y-z$ and 3D tracking trajectory:
![xyz_wrt_ref](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/90a2186a-1690-4084-be95-a67e52d71433)
![3D_tracking_skew](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/235d1b82-abc4-488d-9114-9014b77fcf3f)

The decay lambda has a major impact on the tracking error, which is illustrated below:   
![lambda_effect](https://github.com/duongdinhph/OTCP_Quad/assets/56771011/29b80a77-7ef7-49ed-9832-b04d9edacad6)


# 5. Conclusion
In this project, a novel control strategy that consists of the Off-policy RL algorithm was proposed. By
collecting data to train two actor-critic networks (NNs) which aim to estimate the optimal controllers including a position controller and attitude controller, this structure has the advantage of no need
of any prior information on the high coupling system. Finally, simulation results are provided to
illustrate the tracking performance of a sophisticated trajectory of the system.


