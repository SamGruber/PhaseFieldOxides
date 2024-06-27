//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "oliveTestApp.h"
#include "oliveApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

InputParameters
oliveTestApp::validParams()
{
  InputParameters params = oliveApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

oliveTestApp::oliveTestApp(InputParameters parameters) : MooseApp(parameters)
{
  oliveTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

oliveTestApp::~oliveTestApp() {}

void
oliveTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  oliveApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"oliveTestApp"});
    Registry::registerActionsTo(af, {"oliveTestApp"});
  }
}

void
oliveTestApp::registerApps()
{
  registerApp(oliveApp);
  registerApp(oliveTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
oliveTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  oliveTestApp::registerAll(f, af, s);
}
extern "C" void
oliveTestApp__registerApps()
{
  oliveTestApp::registerApps();
}
