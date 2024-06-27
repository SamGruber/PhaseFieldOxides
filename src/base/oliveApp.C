#include "oliveApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
oliveApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

oliveApp::oliveApp(InputParameters parameters) : MooseApp(parameters)
{
  oliveApp::registerAll(_factory, _action_factory, _syntax);
}

oliveApp::~oliveApp() {}

void
oliveApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAllObjects<oliveApp>(f, af, s);
  Registry::registerObjectsTo(f, {"oliveApp"});
  Registry::registerActionsTo(af, {"oliveApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
oliveApp::registerApps()
{
  registerApp(oliveApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
oliveApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  oliveApp::registerAll(f, af, s);
}
extern "C" void
oliveApp__registerApps()
{
  oliveApp::registerApps();
}
