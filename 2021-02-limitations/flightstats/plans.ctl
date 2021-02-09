console.info("Running controller file...");
$scope.metricsMode = false;

// Selects first plan in agreement
$scope.currentPlan = (!!$scope.model.plans && Object.keys($scope.model.plans).length > 0) ? Object.keys($scope.model.plans)[0] : "";
$scope.showQuotaEditor = false;
$scope.showRateEditor = false;

$scope.periodicity = ["secondly", "minutely", "hourly", "daily", "weekly", "monthly", "quaterly", "yearly"];

var repoExternalURL = "https://repo.designer.governify.io";
var repoInternalURL = "http://repo.designer.governify.io:10880";
/**
$scope.planNameToChange = $scope.currentPlan;
$scope.$watch(
    function(scope) { 
        return $scope.planNameToChange;
    }, function(newValue, oldValue) {
        
        var i=0; var index=0;
        angular.forEach(Object.keys($scope.model.plans), function (planToRename) {
            if (oldValue === planToRename)
                index = i;
            i++;
        });
        //TODO: rename i-plan name with newValue
        $scope.plans[newValue] = $scope.plans[oldValue];
        delete $scope.plans[oldValue]
        console.info(index, newValue, oldValue);
    }, true
); */

$scope.addNewRateInPath = function (path) {
    console.info("addNewRateInPath");
    if (!!$scope.model.plans && !!$scope.model.plans[$scope.currentPlan]) {
        if (!$scope.model.plans[$scope.currentPlan].rates) $scope.model.plans[$scope.currentPlan].rates = {};
        if (!$scope.model.plans[$scope.currentPlan].rates[path]) $scope.model.plans[$scope.currentPlan].rates[path] = {};

        $scope.model.plans[$scope.currentPlan].rates[path]["select"] = {
            "select": {}
        };
    }
};

$scope.addNewQuota = function (path, num, operation, metric, period) {
    if (!!$scope.model.plans && !!$scope.model.plans[$scope.currentPlan] && !isNaN(num) && operation != 'select...' && metric != 'select...' && period != 'select...') {
        console.info("addNewQuota");
        if (!$scope.model.plans[$scope.currentPlan].quotas[path]) {
            $scope.model.plans[$scope.currentPlan].quotas[path] = {};
        }
        if (!$scope.model.plans[$scope.currentPlan].quotas[path][operation]) {
            $scope.model.plans[$scope.currentPlan].quotas[path][operation] = {};
        }
        $scope.model.plans[$scope.currentPlan].quotas[path][operation][metric] = [{
            "max": num,
            "period": period
        }];
        $scope.showRateEditor = false;
        console.log("created rate in", $scope.model.plans[$scope.currentPlan].quotas[path]);
    } else {
        console.warn("Unable to create new rate with parameters:", path, num, operation, metric, period);
    }
};
$scope.addNewRate = function (path, num, operation, metric, period) {
    if (!!$scope.model.plans && !!$scope.model.plans[$scope.currentPlan] && !isNaN(num) && operation != 'select...' && metric != 'select...' && period != 'select...') {
        console.info("addNewRate");
        if (!$scope.model.plans[$scope.currentPlan].rates[path]) {
            $scope.model.plans[$scope.currentPlan].rates[path] = {};
        }
        if (!$scope.model.plans[$scope.currentPlan].rates[path][operation]) {
            $scope.model.plans[$scope.currentPlan].rates[path][operation] = {};
        }
        $scope.model.plans[$scope.currentPlan].rates[path][operation][metric] = [{
            "max": num,
            "period": period
        }];
        $scope.showRateEditor = false;
        console.log("created rate in", $scope.model.plans[$scope.currentPlan].rates[path]);
    } else {
        console.warn("Unable to create new rate with parameters:", path, num, operation, metric, period);
    }
};
$scope.addNewGuarantee = function (path, objective, operation, period) {
    if (!!$scope.model.plans && !!$scope.model.plans[$scope.currentPlan] && !!objective && operation != 'select...' && period != 'select...') {
        console.info("addNewGuarantee");
        if (!$scope.model.plans[$scope.currentPlan].guarantees[path]) {
            $scope.model.plans[$scope.currentPlan].guarantees[path] = {};
        }
        if (!$scope.model.plans[$scope.currentPlan].guarantees[path][operation]) {
            $scope.model.plans[$scope.currentPlan].guarantees[path][operation] = {};
        }
        var auxObj = {
            "objective": objective,
            "period": period,
            "window": "dynamic"
        };
        if ($scope.model.plans[$scope.currentPlan].guarantees[path][operation].length > 0) {
            $scope.model.plans[$scope.currentPlan].guarantees[path][operation].push(auxObj);
        } else {
            $scope.model.plans[$scope.currentPlan].guarantees[path][operation] = [auxObj];
        }
        $scope.showGuaranteeEditor = false;
        console.log("created rate in", $scope.model.plans[$scope.currentPlan].guarantees[path]);
    } else {
        console.warn("Unable to create new rate with parameters:", path, objective, operation, period);
    }
};

// Add quota
$scope.addNewRatePath = function (path) {
    console.info("addNewRatePath");
    if (path != "select...") {
        if (!$scope.model.plans[$scope.currentPlan]["rates"])
            $scope.model.plans[$scope.currentPlan]["rates"] = {};
        $scope.model.plans[$scope.currentPlan]["rates"][path] = {};
    }
};
$scope.addNewQuotaPath = function (path) {
    console.info("addNewQuotaPath");
    if (path != "select...") {
        if (!$scope.model.plans[$scope.currentPlan]["quotas"])
            $scope.model.plans[$scope.currentPlan]["quotas"] = {};
        $scope.model.plans[$scope.currentPlan]["quotas"][path] = {};
    }
};
$scope.addNewGuaranteePath = function (path) {
    console.info("addNewGuaranteePath");
    if (path != "select...") {
        if (!$scope.model.plans[$scope.currentPlan]["guarantees"])
            $scope.model.plans[$scope.currentPlan]["guarantees"] = {};
        $scope.model.plans[$scope.currentPlan]["guarantees"][path] = {};
    }
};

// Remove path
$scope.removeQuotaPath = function (path) {
    console.info("removeQuotaPath");
    delete $scope.model.plans[$scope.currentPlan].quotas[path];
};
$scope.removeRatePath = function (path) {
    console.info("removeRatePath");
    delete $scope.model.plans[$scope.currentPlan].rates[path];
};
$scope.removeGuaranteePath = function (path) {
    console.info("removeRatePath");
    delete $scope.model.plans[$scope.currentPlan].guarantees[path];
};
$scope.removeGuarantee = function (index) {
    $scope.model.plans[$scope.currentPlan].guarantees.global.global.splice(index, 1);
};

// Remove Item
$scope.removeQuotaItem = function (path, operation, metric, max, period) {
    console.info("removeQuotaItem");
    var i = 0; var index = -1;
    angular.forEach($scope.model.plans[$scope.currentPlan].quotas[path][operation][metric], function (element) {
        if (element.max == max && element.period == period) {
            index = i;
        }
        i++;
    });
    $scope.model.plans[$scope.currentPlan].quotas[path][operation][metric].splice(index, 1);
};
$scope.removeRateItem = function (path, operation, metric, max, period) {
    console.info("removeRateItem");
    var i = 0; var index = -1;
    angular.forEach($scope.model.plans[$scope.currentPlan].rates[path][operation][metric], function (element) {
        if (element.max == max && element.period == period) {
            index = i;
        }
        i++;
    });
    $scope.model.plans[$scope.currentPlan].rates[path][operation][metric].splice(index, 1);
};
$scope.removeGuaranteeItem = function (path, operation, objective, period, window) {
    console.info("removeGuaranteeItem");
    var i = 0; var index = -1;
    angular.forEach($scope.model.plans[$scope.currentPlan].guarantees[path][operation], function (element) {
        if (element.period == period && element.period == period) {
            index = i;
        }
        i++;
    });
    $scope.model.plans[$scope.currentPlan].guarantees[path][operation].splice(index, 1);
};

/**
 * Updates current plan
 */
$scope.updateCurrentPlan = function (planId) {
    $scope.currentPlan = planId;
    $scope.showQuotaEditor = false;
    $scope.planNameToChange = planId;
};

// Loads oasDocument.yaml file content
var loadOASFile = function () {
    var oasFileURL = $scope.model.context.api.replace(repoInternalURL, repoExternalURL);
    console.log("GET request to ", oasFileURL);
    $.ajax({
        url: oasFileURL,
        method: 'GET',
        timeout: 3600000
    }).done(function (data, textStatus, jqXHR) {
        if (jqXHR.status !== 200) {
            console.log(jqXHR);
            CommandApi.echo("Unable (" + jqXHR.status + ") to find OAI Specification in " + oasFileURL);
        } else {
            $scope.oasDocument = jsyaml.safeLoad(data);
            console.info($scope.oasDocument);
        }
    }).fail(function (jqXHR, textStatus, errorThrown) {
        CommandApi.echo("Unable to find OAI Specification in " + oasFileURL);
    });
};
loadOASFile();

/**
 * Creates a new agreement template based on the current model.
 * @returns {undefined}
 */
$scope.createNewModel = function () {
    var constraintName = $('#planName').val();
    $('#planName').val("");
    if (!$scope.model.plans)
        $scope.model["plans"] = {};
    if (constraintName != "" && !(constraintName in $scope.model.plans)) {
        $scope.model.plans[constraintName] = {
            "pricing": {
                "cost": 0
            },
            "quotas": "",
            "rates": "",
            "guarantees": ""
        };
    } else {
        console.warn("Please, define a valid plan name", constraintName);
    }
};
$scope.renameModel = function () {
    var constraintName = $('#planName').val();
    $('#planName').val("");
    if (constraintName != "" && $scope.model.plans && !(constraintName in $scope.model.plans)) {
        var plansCopy = jsyaml.safeLoad(jsyaml.safeDump($scope.model.plans));
        plansCopy[constraintName] = plansCopy[$scope.currentPlan];
        delete plansCopy[$scope.currentPlan];
        $scope.model.plans = plansCopy;
        setTimeout(function () {
            $('#petstoreBindingContainer > ul > li > a').each(function () {
                if ($(this).text().replace(/\s+/g, "").toLowerCase() === constraintName) {
                    $(this).click();
                    return false;
                }
            });
        }, 150);
    }
};

// SLA getters
var getPlans = function () {
    return $scope.model.plans;
};

// Remove model element
$scope.removeModel = function (modelId, $event) {
    console.info("removeModel");

    if (Object.keys($scope.model.plans).length > 0) {
        var plansCopy = jsyaml.safeLoad(jsyaml.safeDump($scope.model.plans));
        delete plansCopy[$scope.currentPlan];
        $scope.model.plans = plansCopy;

        if (Object.keys(plansCopy).length > 0) {
            setTimeout(function () {
                jQuery('#petstoreBindingContainer > ul > li.active > a').first().click();
            }, 150);
        }
    }
};

var creationConstraintStructureWithId = function (planId) {
    return {
        "availability": "R/00:00:00Z/23:59:59Z",
        "pricing": {
            "cost": 50
        },
        "configuration": {
            "filteringType": "multipleTags",
            "xmlFormat": "true"
        },
        "quotas": {
            "/pets": {
                "get": {
                    "requests": [
                        {
                            "max": 20,
                            "period": "minutely",
                            "scope": "account"
                        },
                        {
                            "max": 100,
                            "period": "hourly",
                            "scope": "tenant"
                        }
                    ]
                },
                "post": {
                    "requests": [
                        {
                            "max": 100,
                            "period": "minutely"
                        }
                    ],
                    "resourceInstances": [
                        {
                            "max": 500
                        }
                    ],
                    "animalTypes": [
                        {
                            "max": 5
                        }
                    ]
                }
            }
        },
        "guarantees": {
            "global": {
                "global": [
                    {
                        "objective": "responseTimeMs <= 250",
                        "period": "daily",
                        "window": "dynamic"
                    }
                ]
            }
        }
    };
};

$scope.mergeQuotas = function (model, plan) {
    var newAG = $.extend(true, {}, model);
    var quotas = newAG.plans[plan].quotas;

    for (var q in quotas) {
        var quota = quotas[q];
        if (!newAG.quotas[q]) newAG.quotas[q] = {};
        for (m in quota) {
            var method = quota[m];
            if (!newAG.quotas[q][m]) newAG.quotas[q][m] = {};
            for (me in method) {
                var metric = method[me];
                if (!newAG.quotas[q][m][me]) newAG.quotas[q][m][me] = [];

                newAG.quotas[q][m][me] = metric.map((element) => { delete (element.$$hashKey); return element; });
            }
        }
    }

    return newAG.quotas;
}

$scope.mergeRates = function (model, plan) {
    var newAG = $.extend(true, {}, model);
    var rates = newAG.plans[plan].rates;

    for (var q in rates) {
        var rate = rates[q];
        if (!newAG.rates[q]) newAG.rates[q] = {};
        for (m in rate) {
            var method = rate[m];
            if (!newAG.rates[q][m]) newAG.rates[q][m] = {};
            for (me in method) {
                var metric = method[me];
                if (!newAG.rates[q][m][me]) newAG.rates[q][m][me] = [];

                newAG.rates[q][m][me] = metric.map((element) => { delete (element.$$hashKey); return element; });
            }
        }
    }

    return newAG.rates;
};

$scope.createNewMetric = function (metName, metType, metFormat, metDesc, metRes) {
    console.info("createNewMetric");
    if (!!metName && !!metType && !!metFormat && !!metDesc && !!metRes && metType != "select..." && metRes != "select...") {
        if (!("metrics" in $scope.model)) $scope.model.metrics = {};
        $scope.model.metrics[metName] = {
            "type": metType,
            "format": metFormat,
            "description": metDesc,
            "resolution": metRes
        };
    }
};

$scope.removeMetric = function (metName) {
    console.info("removeMetric");
    var isMetricUsed = false;
    angular.forEach($scope.model.plans, function (planProperties, planName) {
        if (!isMetricUsed)
            angular.forEach(planProperties, function (planResources, planProp) {
                if (!isMetricUsed && (planProp === "quotas" || planProp === "rates" || planProp === "guarantees")) {
                    angular.forEach(planResources, function (resources, method) {
                        if (!isMetricUsed)
                            angular.forEach(resources, function (metrics, method) {
                                if (!isMetricUsed && metName in metrics)
                                    isMetricUsed = true;
                            });
                    });
                }
            });
    });
    if (!isMetricUsed) {
        delete $scope.model.metrics[metName];
    } else {
        CommandApi.echo("Unable to remove metric because metric is in used");
    }
};

$scope.copyFromPreviousPlan = function () {
    console.info("copyFromPreviousPlan");
    var i = 0; var index = -1;
    angular.forEach($scope.model.plans, function (values, plan) {
        if (plan == $scope.currentPlan) {
            index = i;
        }
        i++;
    });
    if (index > 0) {
        var sourcePlanName = Object.keys($scope.model.plans)[index - 1];
        var targetPlanName = Object.keys($scope.model.plans)[index];
        $scope.model.plans[targetPlanName] = jsyaml.safeLoad(jsyaml.safeDump($scope.model.plans[sourcePlanName]));
        CommandApi.echo("Plan copied from \"" + sourcePlanName + "\" plan");
    } else {
        CommandApi.echo("Please, select another plan to copy. This is the first plan");
    }
};