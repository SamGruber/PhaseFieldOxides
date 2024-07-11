#
# Solving the Basic Cahn-Hilliard equation with an effective-type mobility
# have not figured out how to implement this yet
# NEED TO FIX

[Mesh]
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

[Kernels]
  [./w_dot]
    variable = w
    v = c
    type = CoupledTimeDerivative
  [../]
  [./coupled_res]
    variable = w
    type = SplitCHWResAniso
    mob_name = M_eff
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
    type = GenericConstantMaterial
    prop_names = 'kappa_c M_iso_11 M_iso_22 M_ani_11 M_ani_22'
    prop_values = '0.1 0.1 0.1 0.3 0.2'
  [../]
  [./M_eff]
    type = ParsedMaterial
    property_names = 'M11 M22 M_eff'
    coupled_variables = 'c'
    function1 = '0.3*0.1/(c*0.3+(1-c)*0.1)'
    function2 = '0.2*0.1/(c*0.2+(1-c)*0.1)'
    function = '[function1, 0, 0; 0, function2, 0; 0, 0, 0]'
    enable_jit = true
    outputs = exodus
  [../]
  [./free_energy]
    type = DerivativeParsedMaterial
    property_name = f_loc
    coupled_variables = 'c'
    constant_names = 'W'
    constant_expressions = 3.1
    expression = 'c*log(c)+(1-c)*log(1-c)+W*c*(1-c)'
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

[Postprocessors]
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
petsc_options_iname = '-pc_type -ksp_gmres_restart -sub_ksp_type -sub_pc_type -pc_asm_overlap'
petsc_options_value = 'asm 1000 preonly ilu 2'
[]

[Outputs]
exodus = true
console = true
csv = true
[]
