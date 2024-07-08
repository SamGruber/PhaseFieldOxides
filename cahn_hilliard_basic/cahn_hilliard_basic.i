#
# Solving the Basic Cahn-Hilliard equation with the 
# main interest of observing differences due to change in mobility value.
#

[Mesh]
    # generate a 2D, 25nm x 25nm mesh
    type = GeneratedMesh
    dim = 2
    elem_type = QUAD4
    nx = 300
    ny = 300
    nz = 0
    xmin = 0
    xmax = 50
    ymin = 0
    ymax = 50
    zmin = 0
    zmax = 0
  []
  
  [Variables]
    [./c] 
      order = FIRST
      family = LAGRANGE
    [../]
    [./w]
      order = FIRST
      family = LAGRANGE
    [../]
  []
  
  [ICs]
    [./cIC]
      type = RandomIC
      variable = c
      min = 0.48
      max = 0.52
    [../]
  []
  
  #[BCs] No BCs at the moment as the default is \partialu\partialn = 0, the so-called natural BC
  #[]
  
  [Kernels]
    [./w_dot]
      variable = w
      v = c
      type = CoupledTimeDerivative
    [../]
    [./coupled_res]
      variable = w
      type = SplitCHWRes
      mob_name = M
    [../]
    [./coupled_parsed]
      variable = c
      type = SplitCHParsed
      f_name = f_loc
      kappa_name = kappa_c
      w = w
    [../]
  []
  
  [Materials]
    [./constants]
      type = GenericFunctionMaterial
      prop_names = 'kappa_c M' # Change this mobility value to observe differences
      prop_values = '0.1 0.8'
    [../]
    [./free_energy]
    type = DerivativeParsedMaterial
    property_name = f_loc
    coupled_variables = c
    constant_names = 'W'
    constant_expressions = 2.5
    # expression = W*(1-c)^2*(1+c)^2
    expression = c*log(c)+(1-c)*log(1-c)+W*c*(1-c)
    enable_jit = true
    outputs = exodus
    [../]
  []

  [Preconditioning]
    [./coupled]
      type = SMP
      full = true
    [../]
  []

  [Postprocessors] # Make sure to divide by system volume when plotting as this returns only the element volume
  [./integral_c]
    type = ElementIntegralVariablePostprocessor
    variable = c
  [../]
  [./integral_w]
    type = ElementIntegralVariablePostprocessor
    variable = w
  [../]
[]

  [Executioner]
    type = Transient
    solve_type = PJFNK
    scheme = bdf2
    l_max_its = 150
    l_tol = 1e-6
    nl_max_its = 20
    nl_abs_tol = 1e-9
    end_time = 10
    dt = 0.2
    # petsc_options = '-pc_svd_monitor'    
    petsc_options_iname = '-pc_type -ksp_gmres_restart -sub_ksp_type
                           -sub_pc_type -pc_asm_overlap'
    petsc_options_value = 'asm      1000                  preonly
                           ilu          2'
    #auto_preconditioning = true
    #automatic_scaling = true                       
  []

[Outputs]
  exodus = true
  console = true
  csv = true
[]
