'''Models for predicting 30-year mortgage rates.'''

import warnings
warnings.filterwarnings("ignore")
import statsmodels.api as sm
import pandas as pd

from .utils import compute_margin

class MortgageRateModel(object):
    '''A 12-order autoregressive model to predict mortgage rates.

       Paramters
       ---------
       mortgage_rates: Pandas Series with DateTimeIndex
         The monthly mortgage rate to fit
         a 12-order autoregressive model.'''

    def __init__(self, mortgage_rates):
        '''Initialize and fit the model.'''
        self.mortgage_rates = mortgage_rates
        self._model = sm.tsa.SARIMAX(mortgage_rates, order=(12, 0,0))
        self.fit()

    def fit(self, *args, **kwargs):
        '''Fit the model

        Parameters
        ----------
        All parameters are passed to the statsmodels
        SARIMAX fit() member method.
        If disp is not passed it is set to False.'''

        if 'disp' not in kwargs:
            kwargs['disp'] = False

        self.model = self._model.fit(*args, **kwargs)

    def forecast(self, month, confint=0.95):
        '''Forecast the 30-year mortgage rate over the given month.

        Parmaters
        ---------
        month: str
               Parsible month-year to forecast
        confint: float (<= 1)
                 Confidence interval to compute
                 margin of error

        Returns
        -------
        rate  : The forecasted mortgage rate
        margin: The margin of error'''

        last_known = self.mortgage_rates.index[-1]
        if pd.to_datetime(month) < pd.to_datetime(last_known):
            raise ValueError('The month to predict must be after {}' \
                              .format(last_known.strftime('%B %Y')))

        forecast = self.model.get_prediction(last_known, month, confint=confint)
        rate = forecast.predicted_mean.values[-1]
        margin = compute_margin(forecast.se_mean.values[-1], confint)
        return rate, margin
